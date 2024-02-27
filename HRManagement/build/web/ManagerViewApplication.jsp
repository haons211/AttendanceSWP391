<%--
    Document   : test
    Created on : Feb 23, 2024, 11:14:17 PM
    Author     : Admin
--%>

<%@ page import="models.AccountDTO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

    <title>Departments</title>
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
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
                <div class="col-sm-5 col-5">
                    <h4 class="page-title">Inbox</h4>
                </div>
                <!--                        <div class="col-sm-7 col-7 text-right m-b-30">
                                            <a href="addDep" class="btn btn-primary btn-rounded"><i class="fa fa-plus"></i> Add Department</a>
                                        </div>-->
            </div>
            <div class="main-option">

                <div class="main-option-search">
                    <nav class="navbar navbar-light bg-light justify-content-between">
                        <div class="col-sm-10 col-md-8 col-8 top-action-left">
                            <div class="float-left">
                                <div class="btn-group dropdown-action">
                                    <button type="button" class="btn btn-white dropdown-toggle" data-toggle="dropdown">Type <i class="fa fa-angle-down "></i></button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="viewsendapplication?type_id=0">All</a>
                                        <c:forEach items="${requestScope.list_typeapplication}" var="lta">
                                            <a class="dropdown-item" href="viewsendapplication?type_id=${lta.type_id}">${lta.name}</a>
                                        </c:forEach>
                                    </div>
                                </div>

                            </div>
                            <div class="float-left d-none d-sm-block">
                                <input type="text" placeholder="Search Messages" class="form-control search-message" id="searchInput">
                            </div>
                            <% if (request.getParameter("searchTerm") != null) { %>
                            <% if ((String) request.getAttribute("SearchError") != null && !((String) request.getAttribute("SearchError")).isEmpty()) { %>
                            <span class="text-muted d-none d-md-inline-block" style="color: red; display: block; margin-top: 10px; margin-left: 10px;">
                                        <%= (String) request.getAttribute("SearchError") %>
                                    </span>
                            <% } %>
                            <% } %>


                        </div>
                        <!--                                <form action="department" method="get" class="form-inline">
                                                            <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search"
                                                                   aria-label="Search" style="height: 30px;" >
                                                            <button class="btn btn-outline-success my-2 my-sm-0"
                                                                    type="submit" style="height: 30px;">Search</button>
                                                        </form>-->
                    </nav>
                </div>

            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-striped custom-table mb-0 datatable">
                            <thead>
                            <tr>
                                <!--<th colspan="6">-->
                                <!--<input type="checkbox" id="check_all">-->
                                <!--</th>-->


                                <th><input type="checkbox" id="check_all"></th>

                                <th>Sender</th>
                                <th>Title</th>
                                <th>Status</th>
                                <th>SentDate</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="la" items="${requestScope.list_application}">
                                <tr class="unread clickable-row">
                                    <td>
                                        <input type="checkbox" class="checkmail">
                                    </td>
                                    <td class="name">${la.sender_name}</td>
                                    <td>
                                        <a href="detailapplication?applicationId=${la.application_id}">
                                                ${la.title}
                                        </a>
                                    </td>
                                    <c:choose>
                                        <c:when test="${empty la.formatComDate}">
                                            <td><span class="custom-badge status-red">${la.status}</span></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><span class="custom-badge status-green">complete</span></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td class="mail-date">${la.formatCreDate}</td>
                                </tr>
                            </c:forEach>




                            <!--                                        <tr class="clickable-row" data-href="mail-view.html">
                                                                        <td>
                                                                            <input type="checkbox" class="checkmail">
                                                                        </td>
                                                                        <td><span class="mail-important"><i class="fa fa-star-o"></i></span></td>
                                                                        <td class="name">Twitter</td>
                                                                        <td class="subject">HRMS Bootstrap Admin Template</td>
                                                                        <td></td>
                                                                        <td class="mail-date">30 Nov</td>
                                                                    </tr>-->
                            </tbody>
                        </table>
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
    <!--            		<div id="delete_department" class="modal fade delete-modal" role="dialog">
                                        <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                        <div class="modal-body text-center">
                                                                <img src="assets/img/sent.png" alt="" width="50" height="46">
                                                                <h3>Are you sure want to delete this Department?</h3>
                                                                <div class="m-t-20"> <a href="#" class="btn btn-white" data-dismiss="modal">Close</a>
                                                                        <button type="submit" class="btn btn-danger">Delete</button>
                                                                </div>
                                                        </div>
                                                </div>
                                        </div>
                                </div>-->
</div>
<div class="sidebar-overlay" data-reff=""></div>
<script src="assets/js/jquery-3.2.1.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.slimscroll.js"></script>
<script src="assets/js/Chart.bundle.js"></script>
<script src="assets/js/chart.js"></script>
<script src="assets/js/app.js"></script>
<script src="assets/js/jquery.slimscroll.js"></script>
<script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/dataTables.bootstrap4.min.js"></script>
<script>
    document.getElementById("searchInput").addEventListener("keyup", function (event) {
        if (event.key === "Enter") {
            var searchTerm = this.value;
            window.location.href = "viewsendapplication?searchTerm=" + searchTerm;
        }
    });
</script>
</body>

</html>
