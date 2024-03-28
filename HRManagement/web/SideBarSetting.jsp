<%-- 
    Document   : SideBarSetting
    Created on : Mar 12, 2024, 5:00:43 PM
    Author     : Dan
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>View Application</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    </head>

    <body>
<c:set var="em" value="${requestScope.emp}" />
        <c:forEach items="${requestScope.listNo}" var="notification">
            <c:set var="notificationCount" value="${notificationCount + 1}" />
        </c:forEach>
        <div class="header">
            <div class="header-left">
                <a href="HomeEmployees" class="logo">
                    <img src="assets/img/pngtree-hacker-logo-png-image_6408677.png" width="35" height="35" alt=""><span>BeztTech</span>
                </a>
            </div>
            <a id="toggle_btn" href="javascript:void(0);"><i class="fa fa-bars"></i></a>
            <a id="mobile_btn" class="mobile_btn float-left" href="#sidebar"><i class="fa fa-bars"></i></a>
            <ul class="nav user-menu float-right">
                <li class="nav-item dropdown d-none d-sm-block">
                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown"><i class="fa fa-bell-o"></i> <span class="badge badge-pill bg-danger float-right">${notificationCount}</span></a>
                    <div class="dropdown-menu notifications">
                        <div class="topnav-dropdown-header">
                            <span>Notifications</span>
                        </div>
                        <div class="drop-scroll">
                            <ul class="notification-list">
                                <c:forEach var="notification" items="${listNo}">
                                    <li class="notification-message">
                                        <a href="NotificationDetail?id=${notification.notificationId}">
                                            <div class="media">

                                                <div class="media-body">
                                                    <p class="noti-details"><span class="noti-title">${notification.subject}</span> </p>
                                                    <p class="noti-time"><span class="notification-time">
                                                            <c:out value="${notification.sendTime}" />
                                                        </span></p>

                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="topnav-dropdown-footer">
                            <a href="AllNotification">View all Notifications</a>
                        </div>
                    </div>
                </li>

                <li class="nav-item dropdown has-arrow">
                    <a href="#" class="dropdown-toggle nav-link user-link" data-toggle="dropdown">
                        <span class="user-img">
                            <img class="rounded-circle" src="assets/img/avatar/${em.image}" width="24" alt="Admin">
                            <span class="status online"></span>
                        </span>

                        <c:set var="em" value="${requestScope.emp}" />
                        <span>${em.name}</span>
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="profile">My Profile</a>
                        <a class="dropdown-item" href="UpdateInformation?empID=${em.userId}">Edit Profile</a>
                       
                        <a class="dropdown-item" href="Logout">Logout</a>
                    </div>
                </li>
            </ul>
            <div class="dropdown mobile-user-menu float-right">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item" href="profile">My Profile</a>
                    <a class="dropdown-item" href="UpdateInformation?empID=${em.userId}">Edit Profile</a>
                 
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
                    </body>
