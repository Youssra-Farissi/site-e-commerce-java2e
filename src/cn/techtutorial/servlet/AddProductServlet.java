package cn.techtutorial.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import cn.techtutorial.dao.ProductDao;
import cn.techtutorial.model.Product;

@WebServlet("/add-product")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
                 maxFileSize = 1024 * 1024 * 5,    // 5 MB
                 maxRequestSize = 1024 * 1024 * 5) // 5 MB
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = null;
        try {
            // Establish a new database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecomm", "root", "");

            ProductDao productDao = new ProductDao(con);

            String productName = request.getParameter("productName");
            String productCategory = request.getParameter("productCategory");
            double productPrice = Double.parseDouble(request.getParameter("productPrice"));

            // If productId is -1, it means a new product is being added; otherwise, it's an update
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = new Product(productId, productName, productCategory, productPrice, "");

            // Handling file upload
            Part filePart = request.getPart("productImage");
            String fileName = "";
            if (filePart != null) {
                fileName = extractFileName(filePart);
                if (!fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    try (InputStream inputStream = filePart.getInputStream()) {
                        File file = new File(uploadDir, fileName);
                        Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                }
            }

            product.setImage(fileName);

            Map<String, String> messages = new HashMap<>();

            if (productId == -1) {
                // Adding a new product
                if (productDao.addProduct(product)) {
                    messages.put("success", "Product added successfully!");
                } else {
                    messages.put("error", "Failed to add the product. Please try again.");
                }
            } else {
                // Updating an existing product
                if (productDao.updateProduct(product)) {
                    messages.put("success", "Product updated successfully!");
                } else {
                    messages.put("error", "Failed to update the product. Please try again.");
                }
            }

            request.setAttribute("messages", messages);
            request.getRequestDispatcher("/index1.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();  // Log the exception for debugging purposes
            response.getWriter().println("Error accessing the database.");
        } finally {
            // Close the connection in a finally block to ensure it's always closed
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();  // Log the exception for debugging purposes
                }
            }
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
