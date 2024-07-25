package cn.techtutorial.servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/remove-product")
public class RemoveProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the product ID from the request parameter
        String productIdString = request.getParameter("id");

        if (productIdString != null && !productIdString.isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdString);

                // Call the method to remove the product from the database
                boolean isRemoved = removeProductFromDatabase(productId);

                if (isRemoved) {
                    // Product successfully removed
                    response.sendRedirect("index1.jsp"); // Redirect to admin dashboard or appropriate page
                } else {
                    // Product removal failed
                    response.getWriter().println("Failed to remove product. Please try again.");
                }
            } catch (NumberFormatException e) {
                // Handle the case where the product ID is not a valid integer
                response.getWriter().println("Invalid product ID.");
            } catch (SQLException e) {
                // Handle database-related exceptions
                e.printStackTrace(); // Log the exception for debugging purposes
                response.getWriter().println("Error accessing the database.");
            }
        } else {
            // Handle the case where no product ID is provided in the request
            response.getWriter().println("Product ID not specified.");
        }
    }

    private boolean removeProductFromDatabase(int productId) throws SQLException {
        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/ecomm";
        String username = "ecomm";
        String password = "";

        // SQL statement to delete a product by ID
        String deleteProductSql = "DELETE FROM products WHERE id = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecomm","root","");
             PreparedStatement preparedStatement = connection.prepareStatement(deleteProductSql)) {

            // Set the product ID parameter in the SQL statement
            preparedStatement.setInt(1, productId);

            // Execute the DELETE statement
            int rowsAffected = preparedStatement.executeUpdate();

            // Check if the deletion was successful (rowsAffected > 0)
            return rowsAffected > 0;
        }
    }
}