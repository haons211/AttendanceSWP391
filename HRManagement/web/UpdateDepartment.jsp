<%-- 
    Document   : UpdateDepartment
    Created on : Jan 15, 2024, 9:24:00 AM
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

        <title>Edit Departments</title>
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
            <% } else if (role == 3|| role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Edit Department</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">
                            <!--<a href="addDep" class="btn btn-primary btn-rounded"><i class="fa fa-plus"></i>Edit Department</a>-->
                        </div>

                        <div class="main">
                            <a href="department">
                                <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;">Back</button>
                            </a>

                            <form action="UpdateDepartment" method="post">
                                <div class="mb-3">
                                    <label for="departmentId" class="form-label">Department ID</label>
                                    <input type="text" class="form-control" id="departmentId" name="departmentID" value="${p.department_id}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="departmentName" class="form-label">Department Name</label>
                                    <input type="text" class="form-control" id="departmentName" name="departmentName" value="${p.name}">
                                </div>
                                <div style="color: red">
                                    ${requestScope.messageErrorName}
                                </div>
                                <div class="mb-3">
                                    <label for="departmentCode" class="form-label">Department Code</label>
                                    <input type="text" class="form-control" id="departmentCode" name="departmentCode" value="${p.dep_code}">
                                    <div style="color: red">
                                    ${requestScope.messageErrorCode}
                                </div>
                                </div>
                                <div class="add-to-system">
                                    <button type="submit" class="btn btn-success" style="margin: 10px 0;">Update Department</button>
                                </div>
                            </form>

                            <!-- Hiển thị thông báo thành công hoặc lỗi -->
                            <c:if test="${not empty successMessage}">
                                <div style="color: green" role="alert">
                                    ${successMessage}
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div style="color: red" role="alert">
                                    ${errorMessage}
                                </div>
                            </c:if>
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

