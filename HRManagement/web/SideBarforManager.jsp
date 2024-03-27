<%-- 
    Document   : SideBarforManager
    Created on : Feb 21, 2024, 1:03:10 PM
    Author     : NCM
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html>
    <aside>
        <c:set var="em" value="${requestScope.emp}" />
        <c:forEach items="${requestScope.listNo}" var="notification">
            <c:set var="notificationCount" value="${notificationCount + 1}" />
        </c:forEach>
        <div class="header">
            <div class="header-left">
                <a href="dashboard" class="logo">
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
                        <a class="dropdown-item" href="UpdateInformation?empID=${em.userId}">Edit Profile</a>
                        <a class="dropdown-item" href="Setting">Setting</a>
                        <a class="dropdown-item" href="Logout">Logout</a>
                    </div>
                </li>
            </ul>
            <div class="dropdown mobile-user-menu float-right">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item" href="profile">My Profile</a>
                    <a class="dropdown-item" href="UpdateInformation?empID=${em.userId}">Edit Profile</a>
                    <a class="dropdown-item" href="Setting">Setting</a>
                    <a class="dropdown-item" href="Logout">Logout</a>
                </div>
            </div>
        </div>
        <div class="sidebar" id="sidebar">
            <div class="sidebar-inner slimscroll">
                <div id="sidebar-menu" class="sidebar-menu">
                    <ul>
                        <li class="menu-title">Main</li>

                        <c:if test="${account.getRole() == 1}">
                            <li>
                                <a href="dashboard"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a>
                            </li>
                        </c:if>
                        <c:if test="${account.getRole() == 3}">
                            <li>
                                <a href="HomeManager"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a>
                            </li>
                        </c:if>
                        <li class="submenu">
                            <a href="#"><i class="fa fa-id-card"></i> <span>Attendance</span> <span class="menu-arrow"></a>
                            <ul style="display: none;">
                                <li>
                                    <a href="HomeEmployees"><i class="fa fa-check-square-o"></i> <span>Take Attendance</span></a>
                                </li>
                                <li>
                                    <a href="AttendanceReport"><i class="fa fa-flag-o"></i> <span>Attendance Report</span> </a>
                                </li>
                                <li>
                                    <a href="AttendanceSheet"><i class="fa fa-calendar"></i> <span>Attendance Sheet</span></a>
                                </li>
                            </ul>
                        </li> 
                        <li class="submenu">
                            <a href="employee"><i class="fa fa-id-card"></i> <span>Employees</span> <span class="menu-arrow"></a>
                            <ul style="display: none;">
                                <li><a href="employee"><i class="fa fa-id-card"></i>  Employees List</a></li>
                                <li><a href="insurance"><i class="fa fa-shield"></i>  Insurance</a></li>      
                                <li>
                                    <a href="ListSalary"><i class="fa fa-money"></i> <span>Employee Salary</span> </a>
                                </li>
                            </ul>
                        </li>   
                        <li>
                            <a href="account"><i class="fa fa-users"></i> <span>Accounts</span></a>
                        </li>

                        <li> 
                            <a href="department"><i class="fa fa-hospital-o"></i> <span>Departments</span></a>
                        </li>    

                        <li> 
                            <a href="viewsendapplication"><i class="fa fa-paper-plane-o"></i> <span>View Application</span> </a>
                        </li>



                        <li> 
                            <a href="AllNotification"><i class="fa fa-bell-o"></i> <span>View All Notification</span></a>
                        </li>
                        <li>
                            <a href="ManagerNotification"><i class="fa fa-bell"></i> <span>Notification</span></a>
                        </li> 
                        <li>
                            <a href="ExportFileController"><i class="fa fa-download"></i> <span>Export File</span></a>
                        </li> 
                        <c:if test="${account.getRole() == 3}">
                            <li>
                                <a href="ViewProject"><i class="fa fa-plus-square"></i> <span>Project</span></a>
                            </li>
                        </c:if>
                        <li>
                            <a href="ChatSystem"><i class="fa fa-bell"></i> <span>Chat</span></a>
                        </li>
                        <li class="submenu">
                            <a href="Setting"><i class="fa fa-id-card"></i> <span>Settings</span> <span class="menu-arrow"></a>
                            <ul style="display: none;">
                                <li><a href="ChangePassword"><i class="fa fa-lock"></i>  Change Password</a></li>
                                <li><a href="UpdateCompany"><i class="fa fa-building"></i>  Update Company</a></li>      
                                <li><a href="ViewSalaryEmployee"><i class="fa fa-money"></i> <span>My Salary</span> </a></li>
                                    <c:if test="${account.getUserName() eq 'manageruser'}">
                                    <li>
                                        <a href="ViewFeedback"><i class="fa fa-envelope"></i> <span>View Feedback</span> </a>
                                    </li>
                                </c:if>
                            </ul>
                        </li>     
                    </ul>
                </div>
            </div>
        </div>
    </aside>
</html>
