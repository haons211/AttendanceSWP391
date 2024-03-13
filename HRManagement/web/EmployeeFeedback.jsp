<%-- 
    Document   : EmployeeFeedback
    Created on : Mar 12, 2024, 2:23:22 PM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Salary</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
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
                        <div class="col-sm-4 col-5">
                            <h4 class="page-title">Employee Feedback</h4>
                        </div>
                        <div class="col-sm-8 col-7 text-right m-b-30">
                            <a href="AddFeedback" class="btn btn-primary btn-rounded float-right"><i class="fa fa-plus"></i> Add Feedback</a>
                        </div>
                    </div>
                    <h2>
                        List of feedbacks of <span >${employeeSalary.ename} (${userID})</span>
                    </h2>
                    <div class="main-option" style="margin-top: 30px">

                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">

                                <form action="Feedback" method="get" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search"
                                           aria-label="Search" style="height: 30px;" >
                                    <button class="btn btn-outline-success my-2 my-sm-0"
                                            type="submit" >Search</button>
                                </form>
                            </nav>
                        </div>

                    </div>

                    <div class="row" style="margin-top: 20px">
                        <div class="col-md-12">
                            <div class="table-responsive">

                                <table class="table table-striped custom-table datatable">

                                    <thead>

                                        <tr>
                                            <th style="width:25%;">Department</th>
                                            <th>Date</th>
                                            <th>Title</th>

                                            <th class="text-right">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${lists}" var="lists">
                                            <tr>
                                                <td>${employeeSalary.dname}</td>

                                                <td>${lists.feedbackDate}</td>
                                                <td>${lists.title} </td>

                                                <td class="text-right">
                                                    <div class="dropdown dropdown-action">
                                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                                                        <div class="dropdown-menu dropdown-menu-right">
                                                            <a class="dropdown-item" href="EditFeedback?id=${lists.feedbackId}"><i class="fa fa-pencil m-r-5"></i> Edit Content</a>
                                                            <a class="dropdown-item" href="#" data-toggle="modal"  onclick="doDelete('${lists.feedbackId}')"><i class="fa fa-trash-o m-r-5"></i>Delete</a>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr> 
                                        </c:forEach>
                                    </tbody>
                                </table>
                                ${id}
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
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/moment.min.js"></script>
        <script src="assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/js/app.js"></script>
        <script type="text/javascript">
                                                            function doDelete(id) {
                                                                if (confirm("are you sure to delete id = " + id)) {
                                                                    window.location = "DeleteFeedback?id=" + id;
                                                                }
                                                            }
        </script>
    </body>

</html>


