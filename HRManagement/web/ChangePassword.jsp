<%-- 
    Document   : ChangePassword
    Created on : Feb 26, 2024, 11:22:30 PM
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
                                <form class="form" action="ChangePassword" method="post">
                                    <div class="account-logo">
                                        <a href="HomeEmployees"><img src="assets/img/pngtree-hacker-logo-png-image_6408677.png" alt=""></a>
                                    </div>
                                    <div class="form-group">
                                        <label>Current password</label>
                                        <div class="input-group mb-3">
                                            <input type="password" class="form-control" id="oldPassword" name ="currentPassword" placeholder="Current password" value="${curPass}" required=""  />
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('#oldPassword')">
                                                    <span class="fas fa-eye"></span>                                    
                                                </button>
                                            </div>
                                        </div>
                                        <div class ="message-error" style="color: red">
                                            ${requestScope.messageErrorIncorrect}
                                            ${requestScope.messageErrorCur}
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="newPassword">New Password</label>
                                        <div class="input-group mb-3">
                                            <input type="password" class="form-control" id="newPassword" name ="newPassword" placeholder="New password" value="${curPass}" required="" />
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('#newPassword')">
                                                    <span class="fas fa-eye"></span>                                    
                                                </button>
                                            </div>
                                        </div>
                                        <div class ="message-error" style="color: red">
                                            ${requestScope.messageErrorNew}
                                            ${requestScope.messageErrorEqual}
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label for="renewPassword">Re-enter New Password</label>
                                        <div class="input-group mb-3">
                                            <input type="password" class="form-control" id="renewPassword" name ="reNewPassword" placeholder="Re new password" value="${curPass}" required="" />
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('#renewPassword')">
                                                    <span class="fas fa-eye"></span>                                    
                                                </button>
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
            function togglePassword(inputId) {
                const inputElement = document.querySelector(inputId);
                const currentType = inputElement.getAttribute('type');
                inputElement.setAttribute(
                        'type',
                        currentType === 'password' ? 'text' : 'password'
                        );
            }
            function goBack() {
                window.location.href = "http://localhost:9999/HRManagement/Setting";
            }
        </script>

        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
