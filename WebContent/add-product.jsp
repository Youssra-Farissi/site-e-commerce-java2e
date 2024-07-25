<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="cn.techtutorial.connection.DbCon" %>
<%@ page import="cn.techtutorial.dao.ProductDao" %>
<%@page import="cn.techtutorial.dao.AdminDao"%>
<%@ page import="cn.techtutorial.model.Product" %>
<%@ page import="cn.techtutorial.model.Admin" %>
<%@ page import="java.util.*" %>
<%
    Admin adminAuth = (Admin) request.getSession().getAttribute("adminAuth");
    if (adminAuth != null) {
        response.sendRedirect("index1.jsp");
    }
%>
<%

    // If you want to pre-fill the form with existing product details for editing
    int productIdToEdit = -1; // Set the product ID to edit, or -1 for a new product
    ProductDao pd = new ProductDao(DbCon.getConnection());
    Product productToEdit = (productIdToEdit != -1) ? pd.getProductById(productIdToEdit) : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head1.jsp"%>
    <title>Add Product</title>
</head>
<body>

    <div class="container">
        <div class="card-header my-3 text-center">Add Product</div>
        <div class="row justify-content-center">
            <div class="col-md-6 my-3">
                <form action="add-product" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productId" value="<%= (productToEdit != null) ? productToEdit.getId() : -1 %>">
                    <div class="form-group">
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control" id="productName" name="productName" required
                            value="<%= (productToEdit != null) ? productToEdit.getName() : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="productCategory">Product Category</label>
                        <input type="text" class="form-control" id="productCategory" name="productCategory" required
                            value="<%= (productToEdit != null) ? productToEdit.getCategory() : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="productPrice">Product Price</label>
                        <input type="number" class="form-control" id="productPrice" name="productPrice" required
                            value="<%= (productToEdit != null) ? productToEdit.getPrice() : "" %>" step="0.01">
                    </div>
                    
                 
    <!-- Other form fields (productName, productCategory, productPrice) go here -->
    <div class="form-group">
        <label for="productImage">Product Image</label>
        <input type="file" class="form-control-file" id="productImage" name="productImage">
    </div>
    <!-- Add other form fields or buttons as needed -->


                    <button type="submit" class="btn btn-success">Save Product</button>
                    <a href="admin.jsp" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>

    <style>
        /* You can add your custom styles here */
    </style>

    <%@include file="/includes/footer.jsp"%>

</body>
</html>