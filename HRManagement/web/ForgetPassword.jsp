<%-- 
    Document   : ForgetPassword
    Created on : Feb 26, 2024, 12:22:30 PM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Change Password</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" />
        <!-- font awesome 5.13.1 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css" />
    </head>

    <body>
        <div class="main-wrapper account-wrapper">
            <div class="account-page" >
                <div class="account-center">
                    <div class="col-md-6 offset-md-3">

                        <div class="card card-outline-secondary">
                            <div class="card-body">
                                <form class="form" action="ForgetPassword" method="post">

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
                            </div>
                            <c:if test="${successful != null}">
                                <div class="text-center alert-success">
                                    <label > ${successful}</label>    
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function goBack() {
                window.location.href = "http://localhost:9999/HRManagement/Login";
            }
        </script>

        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
