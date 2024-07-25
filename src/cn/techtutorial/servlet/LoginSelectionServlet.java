package cn.techtutorial.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login-selection")
public class LoginSelectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");

        if ("user".equals(role)) {
            response.sendRedirect("login.jsp");
        } else if ("admin".equals(role)) {
            response.sendRedirect("admin.jsp");
        } else {
            // Handle invalid role (optional)
            response.sendRedirect("index.jsp");
        }
    }
}