<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList" %>
<%@page import="cn.techtutorial.dao.AdminDao"%>
<%@page import="cn.techtutorial.model.*"%>


<%
    Admin adminAuth = (Admin) request.getSession().getAttribute("adminAuth");
    if (adminAuth != null) {
        response.sendRedirect("index1.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/includes/head1.jsp" %>
    <title>AdminLogin</title>
</head>
<body>
    <div class="container">
        <div class="card w-50 mx-auto my-5">
            <div class="card-header text-center">Admin Login</div>
            <div class="card-body">
                <form action="admin-login" method="post">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" name="admin-email" class="form-control" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="admin-password" class="form-control" placeholder="Password">
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

            </div>
        </div>
    </div>

    <%@ include file="/includes/footer.jsp" %>
    <!-- jQuery Plugins -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slick.min.js"></script>
		<script src="js/nouislider.min.js"></script>
		<script src="js/jquery.zoom.min.js"></script>
		<script src="js/main.js"></script>
</body>
</html>