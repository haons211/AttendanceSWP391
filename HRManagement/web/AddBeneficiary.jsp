<%@ page import="models.AccountDTO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Add Insurance</title>
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
                            <h4 class="page-title">Add Beneficiary</h4>
                        </div>
                        <div class="main">
                            <a href="beneficiary">
                                <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;">Back</button>
                            </a>                 
                            <form action="addBeneficiary" method="post" >
                                <div class="main-text-table">
                                    <table>
                                        <tr >
                                            <td style="display: none;">
                                                <div class = "right-text-table">
                                                    Beneficiary ID
                                                </div>
                                            </td>
                                            <td style="display: none;">
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="beneficiary_id" value="" style="width: 312px;" >
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class = "right-text-table">
                                                    Employee ID
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="employee_id" value="${employee.employeeId}" style="width: 312px;" readonly="">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Beneficiary Name
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="name" value="" style="width: 312px;">
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorName}
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Gender</td>
                                            <td>
                                                <div class="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <select class="form-control" name="gender" style="width: 312px;">
                                                            <!-- Add options for beneficiaries -->

                                                            <option value="">Select Gender</option>
                                                            <option value="Male">Male</option>
                                                            <option value="Female">Female</option>
                                                            <!-- Add more options as needed -->
                                                        </select>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorGender}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    DOB
                                                </div>
                                            </td>
                                            <td>
                                                <div class = "right-input-table" style="margin-left: 40px" >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="dob"  style="width: 312px;" >
                                                    </div> 
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorDate}
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Relationship</td>
                                            <td>
                                                <div class="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <select class="form-control" name="relationship" style="width: 312px;">
                                                            <!-- Add options for beneficiaries -->

                                                            <option value="">Select Relationship</option>
                                                            <c:forEach var="o" items="${requestScope.relationshipType}">
                                                                <option value="${o.relationship}">${o.relationship}</option>
                                                            </c:forEach>
                                                            <!-- Add more options as needed -->
                                                        </select>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorRelationship}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>  
                                    </table>
                                </div>
                                <div class="add-to-system">
                                    <button type="submit" class="btn btn-success" style="margin: 10px 0 ;">Add Beneficiary</button>
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

