package cn.techtutorial.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import cn.techtutorial.connection.DbCon;
import cn.techtutorial.dao.AdminDao;
import cn.techtutorial.model.Admin;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String adminEmail = request.getParameter("admin-email");
            String adminPassword = request.getParameter("admin-password");

            AdminDao adminDao = new AdminDao(DbCon.getConnection());
            boolean isAdminLoggedIn = adminDao.adminLogin(adminEmail, adminPassword);

            if (isAdminLoggedIn) {
                response.sendRedirect("index1.jsp");
            } else {
                out.println("Invalid admin credentials");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
