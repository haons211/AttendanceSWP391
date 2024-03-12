<%-- 
    Document   : ExportFile
    Created on : Mar 10, 2024, 8:45:41 PM
    Author     : ThuyVy
--%>

<%@ page import="models.AccountDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Export File</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">

        <style>
        .product-list {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .product-list::after {
            content: "";
            display: table;
            clear: both;
        }

        canvas {
            max-width: 500px;
            max-height: 400px;
        }

        .export-options {
            margin-top: 20px;
            
        }

        .export-button {
            margin-top: 50px;
            margin-left: 50px;
        }

        .modal-body {
            max-height: 400px;
            overflow-y: auto;
        }

        /* Styling for the radio buttons and labels */
        input[type="radio"] {
            margin-right: 5px;
        }

        label {
            display: inline-block;
            vertical-align: middle;
            cursor: pointer;
            font-size: large;
        }

        /* Styling for the images */
        img {
            margin-right: 10px;
            max-width: 150px;
            max-height: 150px;
            vertical-align: middle;
            cursor: pointer;
        }
</style>
    </head>

    <body>
        <%
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            int role = acc.getRole();
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
                        <h4 class="page-title">Export File</h4>
                    </div>
                </div>
                <form action="ExportFileController" method="post">
                    <p>Select the type of file you want to export:</p>
                    <div class="row export-options">

                        <div class="col-md-4 text-center">
                            <img src="assets/img/listEmployee.png" alt=""><br>
                            <input type="radio" id="exportEmployee" name="exportType" value="employee">
                            <label for="exportEmployee">Employee List</label>
                            <br>
                        </div>
                        <div class="col-md-4 text-center">
                            <img src="assets/img/listDepartment.png" alt=""><br>
                            <input type="radio" id="exportDepartment" name="exportType" value="department">
                            <label for="exportDepartment">Department List</label>
                            <br>
                        </div>
                        <div class="col-md-4 text-center">
                            <img src="assets/img/attendancelist.png" alt=""><br>
                            <input type="radio" id="exportAttendance" name="exportType" value="attendance">
                            <label for="exportAttendance">Attendance Report</label>
                            <br>


                        </div>
                        <button type="submit" class="btn btn-primary export-button">Export</button>
                        <!--<button><a href="ExportFileController">Xuất excel</a></button>-->

                        ${mess}
                    </div>
                </form>
                    <div class="row">
                        <div class="col-md-12">
                            <!-- Modal for displaying detailed information -->
                            <div class="modal fade" id="exportModal" tabindex="-1" role="dialog" aria-labelledby="exportModalLabel" aria-hidden="true">
                                <!--<div class="modal-dialog" role="document">-->
                                <div class="modal-dialog modal-dialog-centered" style="max-width: fit-content;">
                                    <div class="modal-content" style="width: fit-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exportModalLabel">Export Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Detailed information content goes here -->
                                            <!-- You can dynamically load content based on the export type selected -->
                                            <!-- For example, if 'Employee List' is selected, you can display employee-related information here -->
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
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
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>
        <!-- Script to show export details modal -->
        <script>
            //        $(document).ready(function() {
            //            // Show export details modal when export type is selected
            //            $("input[name='exportType']").change(function() {
            //                $('#exportModal').modal('show');
            //                // Load detailed information based on the selected export type
            //                // You can make AJAX requests here to fetch the information dynamically
            //            });
            //        });
            $(document).ready(function () {
                $("input[name='exportType']").change(function () {
                    var exportType = $(this).val();
                    $.ajax({
                        type: "POST",
                        url: "ExportDetailsServlet",
                        data: {exportType: exportType},
                        success: function (response) {
                            $('#exportModal .modal-body').html(response);
                            $('#exportModal').modal('show');
                        }
                    });
                });
            });

        </script>

    </body>

</html>
