<%-- 
    Document   : ManagerViewFeedback
    Created on : Mar 13, 2024, 12:08:13 AM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>View Feedback</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">

    </head>


    <body>



        <div class="main-wrapper">
            <%@include file="SideBarSetting.jsp" %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">List Feedback</h4>
                        </div>
                    </div>
                    <div class="main-option">
                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">
                                <form action="ViewFeedback" method="get" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search" aria-label="Search" value="${search}" style="height: 30px;">

                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;margin-right: 20px;" value="Search">Search</button>

                                    <label >From:</label>
                                    <input type="date" name="dateFrom" class="form-control" style="height: 30px;  ">

                                    <label >To:</label>
                                    <input type="date" name="dateEnd"class="form-control" style="height: 30px;">

                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px; margin-left: 20px"value="Search">Search</button>

                                </form>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table mb-0 datatable">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Date </th>
                                                <th>Title</th>
                                                <th>View Content</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listf}" var="listf" varStatus = "counter">
                                                <tr class="table_row">
                                                    <td  >${counter.count}</td>
                                                    <td >${listf.feedbackDate}</td>
                                                       <td >${listf.title}</td>
                                                    <td><a class="btn btn-sm btn-primary" href="ViewContentFeedback?id=${listf.feedbackId}">View Content</a></td>
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

        </div>     





        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/moment.min.js"></script>
        <script src="assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>


