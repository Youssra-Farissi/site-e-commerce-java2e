<%@page import="cn.techtutorial.connection.DbCon"%>
<%@page import="cn.techtutorial.dao.ProductDao"%>
<%@page import="cn.techtutorial.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("person", auth);
}%>
<%ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}%>

<!DOCTYPE html>
<html>
<head>
<%@include file="/includes/head.jsp"%>
<title>E-Commerce Cart</title>
</head>
<body>

<div class="container">
    <div class="card-header my-3 text-center">All Products</div>
    <div class="row justify-content-center">
        <%
        if (!products.isEmpty()) {
            for (Product p : products) {
        %>
<div class="col-md-4 my-3">
                    <div class="card">
                        <div class="image-frame text-center">
                            <img class="card-img-top" src="img/<%=p.getImage()%>" alt="Product Image">
                        </div>
                        <div class="card-body text-center">
                            <h5 class="card-title"><%=p.getName()%> </h5>
                            <h6 class="price">Price:  $<%=p.getPrice() %></h6>
                            <h6 class="category">Category: <%=p.getCategory() %></h6>
                            <div class="mt-3 d-flex justify-content-around">
                                <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a> <a
								class="btn btn-danger" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>

                                <a class="btn btn-outline-primary" href="product.jsp?productName=<%=p.getName()%>">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
        <%
        }
        } else {
            out.println("There is no products");
        }
        %>
    </div>
</div>

<style>
    .image-frame {
        border: 1px solid #ddd;
        padding: 10px;
        max-height: 200px;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .image-frame img {
        max-width: 60%;
        max-height: 60%;
    }
    .my-3 {
        margin-bottom: 50px; /* You can adjust the margin-bottom value as needed */
    }
    .card-title {
        margin-top: 20px;
        
    }
</style>


	<%@include file="/includes/footer.jsp"%>
	<!-- jQuery Plugins -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slick.min.js"></script>
		<script src="js/nouislider.min.js"></script>
		<script src="js/jquery.zoom.min.js"></script>
		<script src="js/main.js"></script>
</body>
</html>	  

