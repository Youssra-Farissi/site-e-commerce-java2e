<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
Admin adminAuth = (Admin) request.getSession().getAttribute("adminAuth");
if (adminAuth != null) {
	request.setAttribute("person", adminAuth);
}%>
<%ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
    request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@include file="/includes/head1.jsp"%>
    <style>
        .product-card {
            margin: 10px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: transform 0.3s;
        }

        .product-card:hover {
            transform: scale(1.05);
        }

        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .product-details {
            margin-top: 10px;
        }

        .btn-action {
            margin-top: 10px;
        }

        .confirmation-dialog {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            z-index: 1000;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            max-width: 400px;
        }

        .confirmation-dialog h3 {
            margin-bottom: 20px;
            color: #333;
        }

        .confirmation-dialog p {
            color: #666;
        }

        .confirmation-buttons {
            display: flex;
            justify-content: space-between;
        }

        .confirmation-dialog button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .confirmation-dialog button.confirm {
            background-color: #d9534f; /* Bootstrap's danger color */
            color: #fff;
        }

        .confirmation-dialog button.cancel {
            background-color: #5bc0de; /* Bootstrap's info color */
            color: #fff;
        }
    </style>
    <title>Admin Dashboard</title>
</head>
<body>

    <div class="container">
        <div class="card-header my-3 text-center">Admin Dashboard</div>
        <div class="row justify-content-center">
            <div class="col-md-12 my-3">
                <a class="btn btn-success" href="add-product.jsp">Add New Product</a>
            </div>
            
            <% if (!products.isEmpty()) { 
                for (Product p : products) { %>
                    <div class="col-md-4 my-3">
                        <div class="product-card">
                            <div class="image-frame text-center">
                                <img class="product-image" src="img/<%=p.getImage()%>" alt="Product Image">
                            </div>
                            <div class="product-details text-center">
                                <h5 class="card-title"><%=p.getName()%></h5>
                                <h6 class="price">Price: $<%=p.getPrice() %></h6>
                                <h6 class="category">Category: <%=p.getCategory() %></h6>
                                <div class="mt-3">
                                    <a class="btn btn-warning btn-action" href="edit-product.jsp?id=<%=p.getId()%>">Edit Product</a>
                                    <a class="btn btn-danger btn-action" onclick="showConfirmationDialog(<%=p.getId()%>)">Remove Product</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } 
            } else { %>
                <div class="col-md-12">
                    <p class="text-center">There are no products available.</p>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Confirmation Dialog -->
    <div id="confirmationDialog" class="confirmation-dialog">
        <h3>Confirm Removal</h3>
        <p>Are you sure you want to remove the product?</p>
        <div class="confirmation-buttons">
            <button class="btn confirm" onclick="confirmRemove()">Remove Product</button>
            <button class="btn cancel" onclick="cancelRemove()">Cancel</button>
        </div>
    </div>

    <script>
        // JavaScript to show/hide confirmation dialog
        function showConfirmationDialog(productId) {
            const confirmationDialog = document.getElementById('confirmationDialog');
            confirmationDialog.style.display = 'block';

            // Function to confirm removal
            window.confirmRemove = function () {
                // Redirect to the remove-product URL with the product ID
                window.location.href = 'remove-product?id=' + productId;
            };

            // Function to cancel removal
            window.cancelRemove = function () {
                confirmationDialog.style.display = 'none';
            };
        }
    </script>

    <%@include file="/includes/footer.jsp"%>

</body>
</html>