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

        <title>Insurance</title>
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
                min-width: 120px;
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
                            <h4 class="page-title">Insurance</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">
                            <a href="beforeAddInsurance" class="btn btn-primary btn-rounded"><i class="fa fa-plus"></i> Add Insurance</a>
                        </div>
                    </div>
                    <div class="main-option">
                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">
                                <form action="insurance" method="get" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search" aria-label="Search" style="height: 30px;">
                                    <label class="focus-label">Type of Insurance:</label>
                                    <select class="form-control mr-sm-2" name="typeName">
                                        <option value="">Select Type</option>
                                        <c:forEach var="o" items="${requestScope.typeList}">
                                            <option value="${o.coverageType}">${o.coverageType}</option>
                                        </c:forEach>
                                    </select>
<!--                                    <label class="focus-label">Premium Amount</label>
                                    <select class="form-control mr-sm-2" name="amount">
                                        <option value="10000">Select Range ($)</option>
                                        <option value="500">&lt;500$</option>
                                        <option value="1000">&lt;1000$</option>
                                        <option value="5000">&lt;5000$</option>
                                    </select>-->
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
                                            <th>Insurance ID</th>
                                            <th>Employee ID</th>
                                            <th>Image</th>
                                            <th>Employee Name</th>
                                            <th>Gender</th>
                                            <th>Address</th>
                                            <th>Insurance Company</th>
                                            <th>Coverage Type</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Premium Amount</th>
                                            <th>Beneficiary</th>
                                            <th class="text-right">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${requestScope.list}">
                                            <tr class="table_row">
                                                <td>${o.insuranceId}</td>   
                                                <td>${o.employeeId}</td>
                                                <td class="column-2">${o.image}</td>
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
                                                <td>${o.address}</td>
                                                <td>${o.insuranceCompany}</td>
                                                <td>${o.coverageType}</td>
                                                <td>${o.startDate}</td>
                                                <td>${o.endDate}</td>
                                                <td>${o.premiumAmount}</td>
                                                <td>
                                                    ${empty o.beneficiary ? 'No beneficiary' : o.beneficiary}
                                                </td>
                                                <td class="text-right">
                                                    <div class="dropdown dropdown-action">
                                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                                                        <div class="dropdown-menu dropdown-menu-right">
                                                            <a class="dropdown-item" href="detailInsurance?Iid=${o.insuranceId}"><i class="fa fa-info m-r-10" aria-hidden="true"></i> Detail</a>
                                                            <a class="dropdown-item" href="updateInsurance?Iid=${o.insuranceId}"><i class="fa fa-pencil m-r-5"></i> Edit</a>
                                                            <a class="dropdown-item" href="deleteInsurance?Iid=${o.insuranceId}" data-toggle="modal" data-target="#delete_insurance"  onclick="doDelete('${o.insuranceId}')"><i class="fa fa-trash-o m-r-5"></i> Delete</a>
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
                                                                        if (confirm("Are you sure to delete Insurance ID = " + id)) {
                                                                            window.location = "deleteInsurance?Iid=" + id;
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

