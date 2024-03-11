<%-- 
    Document   : BeforeAddSalary
    Created on : Mar 8, 2024, 4:44:29 PM
    Author     : Dan
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Departments</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    </head>

    <body>
        <%
                AccountDTO acc = (AccountDTO) session.getAttribute("account");
                int role=     acc.getRole();
        %>
        <c:set var="em" value="${requestScope.emp}" />

        <div class="main-wrapper account-wrapper">
            <% if (role == 2) { %>
            <jsp:include page="SideBarforEm.jsp" />
            <% } else if (role == 3||role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>

            <div class="account-page" >
                <div class="account-center">
                    <div class="col-md-6 offset-md-3">

                        <div class="card card-outline-secondary">
                            <div class="card-body">
                                <form class="form" action="BeforeAddSalary" method="post">

                                    <div class="form-group">
                                        <label for="Username">Username</label>
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" id="username" name ="username" placeholder="UserName" required=""  />
                                            <div class="input-group-append">

                                            </div>
                                        </div>
                                    </div>
                                    <div class = "d-flex justify-content-between">
                                        <div  style="margin-top: 35px">
                                            <button class="btn btn-secondary btn-group-toggle float-left" type="submit" onclick="goBack()">Back</button>

                                        </div>
                                        <div class="form-group" style="margin-top: 35px">
                                            <button type="submit" class="btn btn-primary btn-group-toggle float-right">Save</button>
                                        </div>
                                    </div>
                                </form>
                                <c:if test="${fail != null}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Error! </strong>${fail}
                                </div>
                            </c:if>
                            </div>
                            
                            

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function goBack() {
                window.location.href = "http://localhost:9999/HRManagement/ListSalary";
            }
        </script>

        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>    
    </body>

</html>

