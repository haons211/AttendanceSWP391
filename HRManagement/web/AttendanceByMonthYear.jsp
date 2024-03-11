<%-- 
Document   : AttendanceByMonthYear
Created on : Mar 6, 2024, 10:41:55 AM
Author     : ThuyVy
--%>

<%@ page import="models.AccountDTO" %>
<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <title>Attendance Sheet</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    </head>
    <body>
        <%
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            int role = acc.getRole();
        %>
        <form action="AttendanceSheet" method="get">
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
                                <h4 class="page-title">Attendance Sheet</h4>
                            </div>


                        </div>
                        <div class="row filter-row">
                            <div class="col-sm-6 col-md-3">
                                <div class="form-group form-focus">
                                    <label class="focus-label">Employee Name</label>
                                    <input name="search" id="searchInput" type="text" class="form-control floating">
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3">
                                <div class="form-group form-focus select-focus">
                                    <label class="focus-label">Select Month</label>
                                    <select class="select floating" name="Month" id="monthSelect">
                                        <option value="">-</option>
                                        <option value="01">Jan</option>
                                        <option value="02">Feb</option>
                                        <option value="03">Mar</option>
                                        <option value="04">Apr</option>
                                        <option value="05">May</option>
                                        <option value="06">Jun</option>
                                        <option value="07">Jul</option>
                                        <option value="08">Aug</option>
                                        <option value="09">Sep</option>
                                        <option value="10">Oct</option>
                                        <option value="11">Nov</option>
                                        <option value="12">Dec</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3">
                                <div class="form-group form-focus select-focus">
                                    <label class="focus-label">Select Year</label>
                                    <select class="select floating" name="Year" id="yearSelect">
                                        <option value="">-</option>
                                        <%
                                            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                                            for (int year = currentYear; year >= 2010; year--) {
                                        %>
                                        <option value="<%= year %>"><%= year %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3">
                                <button class="btn btn-success btn-block" type="submit">Search</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table mb-0">
                                        <%
    String monthStr = request.getParameter("Month");
    String yearStr = request.getParameter("Year");

    int month = (monthStr != null && !monthStr.isEmpty()) ? Integer.parseInt(monthStr) : 0;
    int year = (yearStr != null && !yearStr.isEmpty()) ? Integer.parseInt(yearStr) : 0;

    // Xác định số ngày trong tháng đã chọn
    Calendar calendar = Calendar.getInstance();
    calendar.set(Calendar.YEAR, year);
    calendar.set(Calendar.MONTH, month - 1); // Trừ đi 1 vì tháng trong Calendar bắt đầu từ 0
    int numDaysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
                                        %>

                                        <thead>
                                            <tr>
                                                <th>Employee</th>
                                                    <%-- Hiển thị các cột từ 1 đến số ngày trong tháng --%>
                                                    <% for (int i = 1; i <= numDaysInMonth; i++) { %>
                                                <th><%= i %></th>
                                                    <% } %>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="employeeAttendanceList" items="${requestScope.attendanceLists}">
                                                <tr>
                                                    <td>${employeeAttendanceList[0].getName()}</td> 
                                                    <c:forEach var="dayAttendance" items="${employeeAttendanceList}">
                                                        <c:choose>
                                                            <c:when test="${dayAttendance.status == 'Present'}">
                                                                <td><i class="fa fa-check text-success"></i></td>
                                                                </c:when>
                                                                <c:when test="${dayAttendance.status == 'Absent'}">
                                                                <td><i class="fa fa-times text-danger"></i></td>
                                                                </c:when>
                                                                <c:otherwise>
                                                                <td></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
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
        </form>
        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/app.js"></script>

    </body>
</html>
