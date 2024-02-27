<%@ page import="models.AccountDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Preclinic - Medical & Hospital - Bootstrap 4 Admin Template</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>
        <div class="main-wrapper">
            <div class="header">
                <div class="header-left">
                    <a href="index.html" class="logo">
                        <img src="assets/img/logo.png" width="35" height="35" alt=""> <span>Preclinic</span>
                    </a>
                </div>
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
                                                    <img alt="John Doe" src="assets/img/user.jpg" class="img-fluid">
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
                            <span>Admin</span>
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="profile.html">My Profile</a>
                            <a class="dropdown-item" href="edit-profile.html">Edit Profile</a>
                            <a class="dropdown-item" href="settings.html">Settings</a>
                            <a class="dropdown-item" href="login.html">Logout</a>
                        </div>
                    </li>
                </ul>
                <div class="dropdown mobile-user-menu float-right">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="profile.html">My Profile</a>
                        <a class="dropdown-item" href="edit-profile.html">Edit Profile</a>
                        <a class="dropdown-item" href="settings.html">Settings</a>
                        <a class="dropdown-item" href="login.html">Logout</a>
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
                                <a href="viewsendapplication"><i class="fa fa-paper-plane-o"></i> <span>View Application</span>
                                </a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-cog"></i> <span>Settings</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <c:set var="detail" value="${requestScope.app}"></c:set>

                <div class="page-wrapper">
                    <div class="content">
                        <div class="row">
                            <div class="col-sm-12">
                                <h4 class="page-title">View Application</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card-box">
                                    <div class="mailview-content">
                                        <div class="mailview-header">
                                            <div class="row">
                                                <div class="col-sm-9">
                                                    <div class="text-ellipsis m-b-10">
                                                        <span class="mail-view-title">${detail.title}</span>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="sender-info">
                                            <div class="sender-img">
                                                <img width="40" alt="" src="assets/img/user.jpg" class="rounded-circle">
                                            </div>
                                            <div class="receiver-details float-left">
                                                <span class="sender-name">${detail.sender_name} (<a href="http://cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="5e3431363034313b1e3b263f332e323b703d3133">[email&#160;protected]</a>)</span>
                                                <span class="receiver-name">
                                                    to <span>${detail.receiver_name}</span>
                                                </span>
                                            </div>
                                            <div class="mail-sent-time">
                                                <span class="mail-time">${detail.create_date}</span>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="mailview-inner">
                                        <p>${detail.content}</p>

                                    </div>
                                </div>
                                <div class="mail-attachments">
                                    <p><i class="fa fa-paperclip"></i>  Attachments -  | <a href="#">Download all</a></p>
                                    <ul class="attachments clearfix text-center">
                                        <li>
                                            <div class="attach-file"><i class="fa fa-file-pdf-o"></i></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">daily_meeting.pdf</a>
                                                <div class="attach-fileize"> 842 KB</div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="attach-file"><i class="fa fa-file-word-o"></i></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">documentation.docx</a>
                                                <div class="attach-fileize"> 2,305 KB</div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="attach-file"><img src="assets/img/placeholder.jpg" alt="Attachment"></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">webdesign.png</a>
                                                <div class="attach-fileize"> 1.42 MB</div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="attach-file"><img src="assets/img/placeholder.jpg" alt="Attachment"></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">webdevelopment.png</a>
                                                <div class="attach-fileize"> 1.1 MB</div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                    <hr>
                                    <br>
                                    <br>
                                    <c:choose>
                                    <c:when test="${empty detail.complete_date}">
                                    <div class="mailview-footer">
                                        <div class="row">
                                            <% if(request.getAttribute("thongbao")!=null) { %>
                                            <div class="col-sm-6 right-action">
                                                <span style="color: #1E824C; font-size: 16px; font-weight: bold;">Delete Successfully</span>
                                            </div>
                                            <div class="col-sm-6 right-action">
                                                <button type="button" class="btn btn-white" onclick="refreshPage()"><i class="fa fa-refresh"></i> Refresh</button>
                                            </div>
                                            <% } %>

                                            <%
                                                AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
                                                if (account.getRole() == 3) {
                                            %>
                                            <div class="col-sm-6 left-action">
                                                <button id="reply-btn" type="button" class="btn btn-white"><i class="fa fa-reply"></i> Reply</button>
                                            </div>
                                            <% } %>

                                            <%
                                                if (account.getRole() == 2) {
                                            %>
                                            <div class="col-sm-6 right-action">
                                                <button type="button" class="btn btn-white" onclick="confirmDelete(${detail.application_id})"><i class="fa fa-trash-o"></i> Delete</button>
                                            </div>
                                            <% } %>
                                        </div>
                                    </div>

                                    <br>
                                        <br>
                                        <div id="reply-form" style="display: none;">
                                            <form action="replyapplication" >
                                                <textarea id="content" name="content" rows="4" cols="100" placeholder="Enter content"></textarea>
                                                <input type="hidden" name="application_id" value=${detail.application_id}>
                                                <br>
                                                <input type="submit" value="Done">
                                            </form>
                                        </div>
                                        

                                    </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="sender-info">
                                            <div class="sender-img">
                                                <img width="40" alt="" src="assets/img/user.jpg" class="rounded-circle">
                                            </div>
                                        <div class="receiver-details float-left">
                                            <span class="sender-name">${detail.receiver_name} (<a href="http://cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="5e3431363034313b1e3b263f332e323b703d3133">[email&#160;protected]</a>)</span>
                                            <span class="receiver-name">
                                                    to <span>${detail.sender_name}</span>

                                                </span>
                                        </div>
                                            <div class="mail-sent-time">
                                                <span class="mail-time">${detail.complete_date}</span>
                                            </div>
                                            <br>
                                            <br>
                                            <hr>
                                        </div>
                                        <div class="mailview-inner">
                                            <p>${detail.replyContent}</p>

                                        </div>
                                    </c:otherwise>
                                    </c:choose>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="notification-box">
                    <div class="msg-sidebar notifications msg-noti">
                        <div class="topnav-dropdown-header">
                            <span>Messages</span>
                        </div>
                        <div class="drop-scroll msg-list-scroll" id="msg_list">
                            <ul class="list-box">
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">R</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Richard Miles </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item new-message">
                                            <div class="list-left">
                                                <span class="avatar">J</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">John Doe</span>
                                                <span class="message-time">1 Aug</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">T</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Tarah Shropshire </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">M</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Mike Litorus</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">C</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Catherine Manseau </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">D</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Domenic Houston </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">B</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Buster Wigton </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">R</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Rolland Webber </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">C</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Claire Mapes </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">M</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Melita Faucher</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">J</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Jeffery Lalor</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">L</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Loren Gatlin</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">T</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Tarah Shropshire</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="topnav-dropdown-footer">
                            <a href="chat.html">See all messages</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>
        <script>
                                                function confirmDelete(applicationId) {
                                                    if (confirm("Do you want to Delete?")) {
                                                        window.location.href = "deleteApplication?application_id=" + applicationId;
                                                    }
                                                }
        </script>
        <script>
            function refreshPage() {
                // Chuyển hướng đến servlet khác
                window.location.href = "viewsendapplication";
            }
            document.getElementById("reply-btn").addEventListener("click", function() {
                document.getElementById("reply-form").style.display = "block";
            });


        </script>


    </body>

</html>