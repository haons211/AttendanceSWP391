<%@ page import="models.AccountDTO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Update Attendance Report</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/employeecss.css">
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
            <% } else if (role == 3|| role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Edit Attendance</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">

                        </div>

                        <div class="main">
                            <a href="AttendanceReport">
                                <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;">Back</button>
                            </a>                 
                            <form action="updateAttendance" method="post" >
                                <div class="main-text-table">
                                    <table>

                                        <tr >
                                            <td>Attendance ID</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small "
                                                               aria-describedby="inputGroup-sizing-sm" value="${ar.attendance_id}"  name="id"  readonly>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorPhoneNumber}
                                                    </div>

                                                </div>
                                            <td>
                                                <div class = "right-text-table">
                                                    Employee Name
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="name" value="${ar.em_name}" style="width: 312px;" readonly>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorAddress}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr >
                                            <td>Department</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${ar.dep_name}"  name="department"  readonly>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorPhoneNumber}
                                                    </div>

                                                </div>
                                            <td>
                                                <div class="right-text-table">
                                                    In Status
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="instatus" value="${ar.in_status}" style="width: 312px;" readonly>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorAddress}
                                                    </div>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr >
                                            <td>Status</td>
                                            <td>
                                                <div class="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="status" value="${ar.status}" style="width: 312px;" readonly>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorPhoneNumber}
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-text-table">
                                                    Out Status
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-input-table" style="margin-left: 40px">                                           
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="outstatus" value="${ar.out_status}" style="width: 312px;" readonly>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorAddress}
                                                    </div>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr >
                                            <td>Check In</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="time" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${ar.in_time}"  name="checkin"  >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.checkInError}
                                                    </div>

                                                </div>
                                            <td>
                                                <div class="right-text-table">
                                                    Date        
                                                </div>
                                            </td>
                                            <td>
                                                <div class = "right-input-table" style="margin-left: 40px" >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="date" value="${ar.date}" style="width: 300px;">
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.dateError}
                                                    </div>                                            
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Check Out</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="time" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${ar.out_time}"  name="checkout"  >
                                                    </div>
                                                </div>
                                            <td>
                                                <div class = "right-text-table">
                                                    Message
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="message" value="${ar.notes}" style="width: 312px;">
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageError}
                                                    </div>         
                                                </div>
                                            </td>

                                        </tr>
                                        <tr >
                                            <td>Remain Day</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${ar.remainDay}"  name="remainday"  >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.remaindayError}
                                                    </div>
                                                </div>
                                            <td>
                                                <div class = "right-text-table">
                                                    Approved Leave Days
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="approvedLeaveDays" value="${ar.approvedLeaveDays}" style="width: 312px;" readonly>
                                                    </div>                                               
                                                </div>
                                            </td>
                                    </table>
                                    <div class="add-to-system">
                                        <button type="submit" class="btn btn-success" style="margin-top: 30px" >Update</button>
                                    </div>
                                </div>
                            </form>
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

    </body>

</html>

