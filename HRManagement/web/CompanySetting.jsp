<%-- 
    Document   : Settting.jsp
    Created on : Feb 26, 2024, 10:38:38 PM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Settting</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">

    </head>
    <body>
        <div class="main-wrapper">
            <div class="header">
                <div class="header-left">
                    <a href="HomeEmployees" class="logo">
                        <img src="assets/img/pngtree-hacker-logo-png-image_6408677.png" width="35" height="35" alt="">
                    </a>
                </div>
                <a id="toggle_btn" href="javascript:void(0);"><i class="fa fa-bars"></i></a>
                <div class="page-title-box float-left">
                    <h3>Setttings</h3>
                </div>
                <a id="mobile_btn" class="mobile_btn float-left" href="#sidebar"><i class="fa fa-bars"></i></a>
                <ul class="nav user-menu float-right">
                    <li class="nav-item dropdown d-none d-sm-block">
                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown"><i class="fa fa-bell-o"></i> <span class="badge badge-pill bg-danger float-right"></span></a>
                        <div class="dropdown-menu notifications">
                            <div class="topnav-dropdown-header">
                                <span>Notifications</span>
                            </div>
                            <div class="drop-scroll">

                                <div class="topnav-dropdown-footer">
                                    <a href="activities.html">View all Notifications</a>
                                </div>
                            </div>
                    </li>
                    <li class="nav-item dropdown d-none d-sm-block">
                        <a href="javascript:void(0);" id="open_msg_box" class="hasnotifications nav-link"><i class="fa fa-comment-o"></i> <span class="badge badge-pill bg-danger float-right"></span></a>
                    </li>
                    <li class="nav-item dropdown has-arrow">
                        <a href="#" class="dropdown-toggle nav-link user-link" data-toggle="dropdown">
                            <span class="user-img"><img class="rounded-circle" src="assets/img/user.jpg" width="40" alt="Admin">
                                <span class="status online"></span></span>
                            <span>${cc}</span>
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="profile">My Profile</a>
                            <a class="dropdown-item" href="UpdateInformation">Edit Profile</a>
                            <a class="dropdown-item" href="Setting">Setting</a>
                            <a class="dropdown-item" href="Logout">Logout</a>
                        </div>
                    </li>
                </ul>
                <div class="dropdown mobile-user-menu float-right">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="profile">My Profile</a>
                        <a class="dropdown-item" href="UpdateInformation">Edit Profile</a>
                        <a class="dropdown-item" href="Setting">Setting</a>
                        <a class="dropdown-item" href="Logout">Logout</a>
                    </div>
                </div>
            </div>
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div class="sidebar-menu">
                        <ul>
                            <c:if test="${account.getRole() == 1}">
                                <li>
                                    <a href="HomeAdmin"><i class="fa fa-home back-icon"></i> <span>Back to Home</span></a>
                                </li>
                            </c:if>
                            <c:if test="${account.getRole() == 2}">
                                <li>
                                    <a href="HomeEmployees"><i class="fa fa-home back-icon"></i> <span>Back to Home</span></a>
                                </li>
                            </c:if>
                            <c:if test="${account.getRole() == 3}">
                                <li>
                                    <a href="HomeManager"><i class="fa fa-home back-icon"></i> <span>Back to Home</span></a>
                                </li>
                            </c:if>
                            <li class="menu-title">Settings</li>
                            <li>
                                <a href="UpdateCompany"><i class="fa fa-building"></i> <span>Company Settings</span></a>
                            </li>
                            <li>
                                <a href="ChangePassword"><i class="fa fa-lock"></i> <span>Change Password</span></a>
                            </li>


                        </ul>
                    </div>
                </div>
            </div>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2">

                            <form action="UpdateCompany" method="post" >
                                <h3 class="page-title">Company Settings</h3>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Company Name </label>
                                            <c:if test="${companyName!=null}">
                                                <input class="form-control" type="text" required="" name="companyName" value="${companyName}">
                                            </c:if>
                                            <c:if test="${companyName==null}">
                                                <input class="form-control" type="text" required="" name="companyName" value="${company.companyName}">
                                            </c:if>

                                            <c:if test="${messageErrorCname!=null}">
                                                <div class="text-center alert-danger">
                                                    <label > ${messageErrorCname}</label>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Contact Person</label>
                                            <c:if test="${employeeName!=null}">
                                                <input class="form-control" type="text" required="" name="employeeName" value="${employeeName}">
                                            </c:if>
                                            <c:if test="${employeeName==null}">
                                                <input class="form-control" type="text" required="" name="employeeName" value="${employee1.name}">
                                            </c:if>

                                            <c:if test="${messageErrorEname!=null}">
                                                <div class="text-center alert-danger">
                                                    <label > ${messageErrorEname}</label>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label>Address</label>

                                            <c:if test="${address!=null}">
                                                <input class="form-control" type="text" required="" name="address" value="${address}">
                                            </c:if>
                                            <c:if test="${address==null}">
                                                <input class="form-control" type="text" required="" name="address" value="${company.address}">
                                            </c:if>

                                            <c:if test="${messageErrorAddress!=null}">
                                                <div class="text-center alert-danger">
                                                    <label > ${messageErrorAddress}</label>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input class="form-control" value="${company.email}" required="" name="email" type="email">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Phone Number</label>
                                            <input class="form-control" value="${company.phoneNumber}" required="" name="phoneNumber" type="text">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Fax</label>
                                            <input class="form-control" value="${company.fax}" required="" name="fax" type="text">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Department Name</label>
                                            <input class="form-control" value="${department.name}" required="" name="departmentName" type="text">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label>Website Url</label>
                                            <input class="form-control" value="${company.website}" required="" name="website" type="text">
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${account.getRole() != 2}">

                                    <div class="row">
                                        <div class="col-sm-12 text-center m-t-20">
                                            <button type="submit" class="btn btn-success submit-btn">Save</button>
                                        </div>
                                    </div>
                                </c:if>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>