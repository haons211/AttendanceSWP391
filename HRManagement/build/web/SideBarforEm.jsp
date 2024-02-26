<%-- 
    Document   : SideBarforEm
    Created on : Feb 21, 2024, 12:59:36 PM
    Author     : NCM
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <aside>
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
                            <img class="rounded-circle" src="assets/img/user.jpg" width="24" alt="Admin">
                            <span class="status online"></span>
                        </span>

                        <c:set var="em" value="${requestScope.emp}" />
                        <span>${em.name}</span>
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="profile">My Profile</a>
                        <a class="dropdown-item" href="UpdateInformation">Edit Profile</a>
                        <a class="dropdown-item" href="settings.html">ChangePassword</a>
                        <a class="dropdown-item" href="Logout">Logout</a>
                    </div>
                </li>
            </ul>
            <div class="dropdown mobile-user-menu float-right">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item" href="profile">My Profile</a>
                    <a class="dropdown-item" href="UpdateInformation">Edit Profile</a>
                    <a class="dropdown-item" href="settings.html">ChangePassword</a>
                    <a class="dropdown-item" href="Logout">Logout</a>
                </div>
            </div>
        </div>
        <div class="sidebar" id="sidebar">
            <div class="sidebar-inner slimscroll">
                <div id="sidebar-menu" class="sidebar-menu">
                    <ul>
                        <li class="menu-title">Main</li>
                        <li>
                            <a href="HomeEmployees"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a>
                        </li>
                     
                        <li>
                            <a href="profile"><i class="fa fa-id-card"></i> <span>Profile</span></a>
                        </li>
                        <li> 
                            <a href="sendapplication"><i class="fa fa-paper-plane-o"></i> <span>Send Application</span> </a>
                        </li>
                        <li> 
                            <a href="viewsendapplication"><i class="fa fa-paper-plane-o"></i> <span>View Application</span> </a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-cog"></i> <span>ChangePassword </span></a>
                        </li>    
                         <li>
                            <a href="AllNotification"><i class="fa fa-bell-o"></i> <span>View All Notification</span></a>
                        </li>  
                        
                    </ul>
                </div>
            </div>
        </div>

    </aside>
</html>
