<%-- 
    Document   : SideBarSetting
    Created on : Mar 12, 2024, 5:00:43 PM
    Author     : Dan
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="header">
    <div class="header-left">
        <a href="HomeEmployees" class="logo">
            <img src="assets/img/pngtree-hacker-logo-png-image_6408677.png" width="35" height="35" alt="">
        </a>
    </div>
    <a id="toggle_btn" href="javascript:void(0);"><i class="fa fa-bars"></i></a>
    <div class="page-title-box float-left">
        <h3>Settings</h3>
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
