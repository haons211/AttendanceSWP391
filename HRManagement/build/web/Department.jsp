<%-- 
    Document   : department
    Created on : Jan 14, 2024, 10:53:39 AM
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

        <title>Departments</title>
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
            <% } else if (role == 3||role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Departments</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">
                            <a href="addDep" class="btn btn-primary btn-rounded"><i class="fa fa-plus"></i> Add Department</a>
                        </div>
                    </div>
                    <div class="main-option">

                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">

                                <form action="department" method="get" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search"
                                           aria-label="Search" style="height: 30px;" >
                                    <button class="btn btn-outline-success my-2 my-sm-0"
                                            type="submit" >Search</button>
                                </form>
                            </nav>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table mb-0 datatable">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Department Name</th>
                                            <th>Department Code</th>
                                            <!--<th>Status</th>-->
                                            <th class="text-right">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${requestScope.list}">
                                            <tr class="table_row">
                                                <td  class="column-1">${o.getDepartment_id()}</td>    
                                                <td  class="column-2">${o.getName()}</td>
                                                <td  class="column-2">${o.getDep_code()}</td>
                                                <!--<td><span class="custom-badge status-green">Active</span></td>-->
                                                <!--<td><span class="custom-badge status-red">Inactive</span></td>-->
                                                <td class="text-right">
                                                    <div class="dropdown dropdown-action">
                                                        <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                                                        <div class="dropdown-menu dropdown-menu-right">
                                                            <a class="dropdown-item" href="UpdateDepartment?pid=${o.getDepartment_id()}"><i class="fa fa-pencil m-r-5"></i> Edit</a>
                                                            <a class="dropdown-item" href="DeleteDepartment?pid=${o.getDepartment_id()}" data-toggle="modal" data-target="#delete_department"  onclick="doDelete('${o.getDepartment_id()}')"><i class="fa fa-trash-o m-r-5"></i> Delete</a>
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
                                                                        if (confirm("Are you sure to delete Department_ID = " + id)) {
                                                                            window.location = "DeleteDepartment?pid=" + id;
                                                                        }
                                                                    }
        </script>
    </body>

</html>
