<%-- 
    Document   : AttendanceReport
    Created on : Feb 17, 2024, 12:07:15 AM
    Author     : ThuyVy
--%>

<%@ page import="models.AccountDTO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Beneficiary</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <style>
            th:nth-child(1),
            td:nth-child(1) {
                min-width: 100px;
            }

            th:nth-child(4),
            td:nth-child(4) {
                min-width: 80px;
            }

            th:nth-child(2),
            td:nth-child(2),
            th:nth-child(3),
            td:nth-child(3),
            th:nth-child(5),
            td:nth-child(5),
            th:nth-child(6),
            td:nth-child(6)
            {
                min-width: 150px;
            }

            th:nth-child(8), td:nth-child(8),
            th:nth-child(9), td:nth-child(9)
            {
                min-width: 100px;
            }

            th:nth-child(7), td:nth-child(7)
            {
                min-width: 120px;
            }

            th:nth-child(10), td:nth-child(10){
                min-width: 130px;
            }
        </style>
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
            <% } else if (role == 3||role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Beneficiary of ${employee.name}</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">
                            <a href="addBeneficiary" class="btn btn-primary btn-rounded"><i class="fa fa-plus"></i> Add Beneficiary</a>
                        </div>
                    </div>
                    <div class="main-option">
                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">
                                <form action="beneficiary" method="get" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search" aria-label="Search" style="height: 30px;">
                                    <label class="focus-label">Relationship</label>
                                    <select class="form-control mr-sm-2" name="relationship">
                                        <option value="">Select Relationship</option>
                                        <c:forEach var="o" items="${requestScope.relationshipType}">
                                            <option value="${o.relationship}">${o.relationship}</option>
                                        </c:forEach>
                                    </select>
                                    <label>From:</label>
                                    <input id="fromDate" type="date" name="fromDate" class="form-control mr-sm-2" style="height: 30px;">
                                    <label>To:</label>
                                    <input type="date" name="toDate" class="form-control mr-sm-2" style="height: 30px;">
                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>                 
                                </form>
                            </nav>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive" style="overflow-x: auto;">
                                <table class="table table-striped custom-table mb-0 datatable">
                                    <thead>
                                        <tr>
                                            <th>Beneficiary ID</th>
                                            <th>Beneficiary Name</th>
                                            <th>Gender</th>
                                            <th>DOB</th>
                                            <th>Relationship</th>
                                            <th class="text-right">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${requestScope.list}">
                                            <tr class="table_row">
                                                <td>${o.dependentId}</td>   
                                                <td class="column-2">${o.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${o.gender}">
                                                            Male
                                                        </c:when>
                                                        <c:otherwise>
                                                            Female
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${o.dateOfBirth}</td>
                                                <td>${o.relationship}</td>
                                                <td class="text-right">
                                                    <div class="dropdown dropdown-action">
                                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                                                        <div class="dropdown-menu dropdown-menu-right">                                      
                                                            <a class="dropdown-item" href="updateBeneficiary?bid=${o.dependentId}"><i class="fa fa-pencil m-r-5"></i> Edit</a>
                                                            <a class="dropdown-item" href="deleteBeneficiary?bid=${o.dependentId}" data-toggle="modal" data-target="#delete_beneficiary"  onclick="doDelete('${o.dependentId}')"><i class="fa fa-trash-o m-r-5"></i> Delete</a>
                                                        </div>
                                                    </div>
                                                </td>
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
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>
        <script type="text/javascript">
                                                                function doDelete(id) {
                                                                    if (confirm("Are you sure to delete Dependent ID = " + id)) {
                                                                        window.location = "deleteBeneficiary?bid=" + id;
                                                                    }
                                                                }
        </script>
        <script>
            // Get today's date in the format YYYY-MM-DD
            function getCurrentDate() {
                let now = new Date();
                let year = now.getFullYear();
                let month = String(now.getMonth() + 1).padStart(2, '0');
                let day = String(now.getDate()).padStart(2, '0');
                return `${year}-${month}-${day}`;
                    }

                    // Set the default value of the "From" input field to today's date
                    document.getElementById('fromDate').value = getCurrentDate();
        </script>
    </body>

</html>

