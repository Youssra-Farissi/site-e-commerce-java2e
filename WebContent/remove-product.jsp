<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="cn.techtutorial.connection.DbCon" %>
<%@ page import="cn.techtutorial.dao.ProductDao" %>
<%@page import="cn.techtutorial.dao.AdminDao"%>
<%@ page import="cn.techtutorial.model.Product" %>
<%@ page import="cn.techtutorial.model.Admin" %>
<%
    Admin adminAuth = (Admin) request.getSession().getAttribute("adminAuth");
    if (adminAuth != null) {
        response.sendRedirect("index1.jsp");
    }
%>

<%@include file="/includes/head1.jsp"%>

<%
    int productId = Integer.parseInt(request.getParameter("id"));
    ProductDao pd = new ProductDao(DbCon.getConnection());
    Product product = pd.getProductById(productId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Remove Product</title>
</head>
<body>

    <div class="container">
        <div class="card-header my-3 text-center">Remove Product</div>
        <div class="row justify-content-center">
            <div class="col-md-6 my-3">
                <% if (product != null) { %>
                    <div class="alert alert-warning" role="alert">
                        <p>Are you sure you want to remove the product "<strong><%= product.getName() %></strong>"?</p>
                        <form action="remove-product" method="post">
                            <input type="hidden" name="id" value="<%= product.getId() %>">
                            <button type="submit" class="btn btn-danger">Remove Product</button>
                            <a href="admin-dashboard.jsp" class="btn btn-secondary">Cancel</a>
                        </form>
                    </div>
                <% } else { %>
                    <p>Error: Product not found.</p>
                <% } %>
            </div>
        </div>
    </div>

    <style>
        /* You can add your custom styles here */
    </style>

    <%@include file="/includes/footer.jsp"%>

</body>
</html>