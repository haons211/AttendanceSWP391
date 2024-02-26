<%-- 
    Document   : updateIn4mationUser
    Created on : Jan 14, 2024, 2:13:04 AM
    Author     : NCM
--%>
<%@ page import="models.AccountDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Preclinic - Medical & Hospital - Bootstrap 4 Admin Template</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    </head>
    <body>
        
           <%
                     AccountDTO acc = (AccountDTO) session.getAttribute("account");
                     int role=     acc.getRole();
        %>

        <c:set var="em" value="${requestScope.emp}" />
        <div class="main-wrapper">
            <% if (role == 2) { %>
            <jsp:include page="SideBarforEm.jsp" />
            <% } else if (role == 3) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-12">
                            <h4 class="page-title">Edit Profile</h4>
                        </div>
                    </div>
                    <form action="UpdateInformation" method="post">
                        <%
               
                        
                                 int accid = acc.getUserID();// Lấy giá trị accid từ dữ liệu đăng nhập, chẳng hạn từ database
                                
                        %>

                        <input type="hidden" id="empId" name="empId" value="<%= accid %>" readonly>
                        <div class="card-box">
                            <h3 class="card-title">Basic Informations</h3>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="profile-img-wrap">
                                        <img class="inline-block" src="assets/img/user.jpg" alt="user">
                                        <div class="fileupload btn">
                                            <span class="btn-text">edit</span>
                                            <input class="upload" type="file">
                                        </div>
                                    </div>

                                    <div class="profile-basic">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group form-focus">
                                                    <label class="focus-label">Full Name</label>
                                                    <input type="text" class="form-control floating" id="empName" name="empName" required><br><br>                
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group form-focus">
                                                    <label class="focus-label">Birth Date</label>
                                                    <div class="cal-icon">
                                                        <input type="date"id="empBirthdate" name="empBirthdate"  class="form-control floating" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group form-focus select-focus">
                                                    <label class="focus-label">Gender</label>
                                                    <select class="select form-control floating" id="empGender" name="empGender"required>
                                                        <option value="0">Male</option>
                                                        <option value="1">Female</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-box">
                            <h3 class="card-title">Contact Informations</h3>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group form-focus">
                                        <input type="hidden" id="empId" name="empId" value="${param.idse}" readonly>
                                        <label class="focus-label">Address</label>
                                        <input type="text" id="empAddress" name="empAddress" class="form-control floating" required>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group form-focus">
                                        <label class="focus-label">Mail</label>
                                        <input type="text" id="empEmail" name="empEmail" class="form-control floating" required>
                                    </div>
                                </div>


                                <div class="col-md-12">
                                    <div class="form-group form-focus">
                                        <label class="focus-label">Phone Number</label>
                                        <input type="text" id="empNumber" name="empNumber" class="form-control floating"required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <

                        <input type="submit" value="Update" name="btAction">
                    </form>
                </div>

            </div>
        </div>
        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/moment.min.js"></script>
        <script src="assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
