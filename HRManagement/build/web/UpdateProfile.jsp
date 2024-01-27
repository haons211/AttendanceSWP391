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
        
        <div class="main-wrapper">
            <div class="header">
                <div class="header-left">
                    <a href="dashboard" class="logo">
                        <img src="assets/img/pngtree-hacker-logo-png-image_6408677.png" width="40" height="40" alt=""/> <span>BeztTech</span>
                    </a>
                </div>
                <a id="toggle_btn" href="javascript:void(0);"><i class="fa fa-bars"></i></a>
                <a id="mobile_btn" class="mobile_btn float-left" href="#sidebar"><i class="fa fa-bars"></i></a>
                <ul class="nav user-menu float-right">
                    <li class="nav-item dropdown d-none d-sm-block">
                        <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown"><i class="fa fa-bell-o"></i> <span class="badge badge-pill bg-danger float-right">3</span></a>
                        <div class="dropdown-menu notifications">
                            <div class="topnav-dropdown-header">
                                <span>Notifications</span>
                            </div>
                            <div class="drop-scroll">
                                <ul class="notification-list">
                                    <li class="notification-message">
                                        <a href="activities.html">
                                            <div class="media">
                                                <span class="avatar">
                                                    <img alt="John Doe" src="assets/img/user.jpg" class="img-fluid rounded-circle">
                                                </span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">John Doe</span> added new task <span class="noti-title">Patient appointment booking</span></p>
                                                    <p class="noti-time"><span class="notification-time">4 mins ago</span></p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="activities.html">
                                            <div class="media">
                                                <span class="avatar">V</span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Tarah Shropshire</span> changed the task name <span class="noti-title">Appointment booking with payment gateway</span></p>
                                                    <p class="noti-time"><span class="notification-time">6 mins ago</span></p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="activities.html">
                                            <div class="media">
                                                <span class="avatar">L</span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Misty Tison</span> added <span class="noti-title">Domenic Houston</span> and <span class="noti-title">Claire Mapes</span> to project <span class="noti-title">Doctor available module</span></p>
                                                    <p class="noti-time"><span class="notification-time">8 mins ago</span></p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="activities.html">
                                            <div class="media">
                                                <span class="avatar">G</span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Rolland Webber</span> completed task <span class="noti-title">Patient and Doctor video conferencing</span></p>
                                                    <p class="noti-time"><span class="notification-time">12 mins ago</span></p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-message">
                                        <a href="activities.html">
                                            <div class="media">
                                                <span class="avatar">V</span>
                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">Bernardo Galaviz</span> added new task <span class="noti-title">Private chat module</span></p>
                                                    <p class="noti-time"><span class="notification-time">2 days ago</span></p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="topnav-dropdown-footer">
                                <a href="activities.html">View all Notifications</a>
                            </div>
                        </div>
                    </li>
                    <li class="nav-item dropdown d-none d-sm-block">
                        <a href="javascript:void(0);" id="open_msg_box" class="hasnotifications nav-link"><i class="fa fa-comment-o"></i> <span class="badge badge-pill bg-danger float-right">8</span></a>
                    </li>
                    <li class="nav-item dropdown has-arrow">
                        <a href="#" class="dropdown-toggle nav-link user-link" data-toggle="dropdown">
                            <span class="user-img"><img class="rounded-circle" src="assets/img/user.jpg" width="40" alt="Admin">
                                <span class="status online"></span></span>
                                 <c:set var="em" value="${requestScope.emp}" />
                            <span>${em.name}</span>
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="profile">My Profile</a>
                            <a class="dropdown-item" href="UpdateInformation">Edit Profile</a>
                            <a class="dropdown-item" href="settings.html">Settings</a>
                            <a class="dropdown-item" href="Login">Logout</a>
                        </div>
                    </li>
                </ul>
                <div class="dropdown mobile-user-menu float-right">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="profile">My Profile</a>
                        <a class="dropdown-item" href="UpdateInformation">Edit Profile</a>
                        <a class="dropdown-item" href="settings.html">Settings</a>
                        <a class="dropdown-item" href="Login">Logout</a>
                    </div>
                </div>
            </div>
            <div class="sidebar" id="sidebar">
                <div class="sidebar-inner slimscroll">
                    <div id="sidebar-menu" class="sidebar-menu">
                        <ul>
                            <li class="menu-title">Main</li>
                            <li>
                                <a href="dashboard"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a>
                            </li>
                            <li>
                                <a href="account"><i class="fa fa-users"></i> <span>Accounts</span></a>
                            </li>
                            <li>
                                <a href="employee"><i class="fa fa-id-card"></i> <span>Employees</span></a>
                            </li>
                            <li> 
                                <a href="department"><i class="fa fa-hospital-o"></i> <span>Departments</span></a>
                            </li>    
                            <li>
                                <a href="#"><i class="fa fa-flag-o"></i> <span>Attendance Report</span> </a>
                            </li>
                            <li> 
                                <a href="sendapplication"><i class="fa fa-paper-plane-o"></i> <span>Send Application</span> </a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-cog"></i> <span>Settings</span></a>
                            </li>    
                        </ul>
                    </div>
                </div>
            </div>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-12">
                            <h4 class="page-title">Edit Profile</h4>
                        </div>
                    </div>
                    <form action="UpdateInformation" method="post">
                        <%
                       AccountDTO acc = (AccountDTO) session.getAttribute("account");
                        
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
