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

        <title>View Application</title>
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
            <% } else if (role == 3 || role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>

            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Application</h4>
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
                                            <th>Sender</th>
                                            <th>Title</th>
                                            <th>Status</th>
                                            <th>SentDate</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="la" items="${requestScope.list_application}">
                                            <tr class="unread clickable-row">
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
                                    </tbody>
                                </table>
                            </div>
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
