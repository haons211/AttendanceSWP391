<%-- 
    Document   : ViewContentFeedback
    Created on : Mar 13, 2024, 2:28:46 AM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>View Content Feedback</title>
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
                            <h3 class="page-title">Content Feedback</h3>
                        </div>
                    </div>
                    <div class="main-option" style="margin-top: 30px">
                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">
                                <form action="ViewFeedback" method="POST" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search" aria-label="Search" style="height: 30px;">

                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;margin-right: 20px;" value="Search">Search</button>

                                    <label >From:</label>
                                    <input type="date" name="dateFrom" class="form-control" style="height: 30px;  ">

                                    <label >To:</label>
                                    <input type="date" name="dateEnd"class="form-control" style="height: 30px;">

                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px; margin-left: 20px"value="Search">Search</button>

                                </form>
                            </nav>
                        </div>




                        <div class="form-group" style="margin-top: 30px">
                            <h3 class="page-title">Content</h3>
                            <textarea class="form-control" id="content" name="content" rows="10" style="resize: none;"  readonly="">${feedback.content}</textarea>
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



