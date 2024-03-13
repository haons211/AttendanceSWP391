<%-- Document : Salary Created on : Mar 7, 2024, 5:47:53 PM Author : Dan --%>
    <%@ page import="models.AccountDTO" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
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
                    <% AccountDTO acc=(AccountDTO) session.getAttribute("account"); int role=acc.getRole(); %>
                        <c:set var="em" value="${requestScope.emp}" />
                        <div class="main-wrapper">
                            <% if (role==2) { %>
                                <jsp:include page="SideBarforEm.jsp" />
                                <% } else if (role==3||role==1) { %>
                                    <jsp:include page="SideBarforManager.jsp" />
                                    <% } %>


                                        <div class="page-wrapper">
                                            <div class="content">
                                                <div class="row">
                                                    <div class="col-sm-4 col-5">
                                                        <h4 class="page-title">Employee Salary</h4>
                                                    </div>
                                                    <div class="col-sm-8 col-7 text-right m-b-30">
                                                        <a href="BeforeAddSalary"
                                                            class="btn btn-primary btn-rounded float-right"><i
                                                                class="fa fa-plus"></i> Add Salary</a>
                                                    </div>
                                                </div>
                                                <div class="main-option">

                                                    <div class="main-option-search">
                                                        <nav
                                                            class="navbar navbar-light bg-light justify-content-between">

                                                            <form action="ListSalary" method="get" class="form-inline">
                                                                <input class="form-control mr-sm-2" name="search"
                                                                    type="text" placeholder="Search" aria-label="Search"
                                                                    style="height: 30px;" value="${search}">
                                                                <button class="btn btn-outline-success my-2 my-sm-0"
                                                                    type="submit">Search</button>
                                                            </form>
                                                        </nav>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="table-responsive">
                                                            <table class="table table-striped custom-table datatable">
                                                                <thead>

                                                                    <tr>
                                                                        <th style="width:25%;">Employee</th>
                                                                        <th>Employee ID</th>
                                                                        <th>Email</th>
                                                                        <th>Joining Date</th>
                                                                        <th>Department</th>
                                                                        <th>Salary</th>
                                                                        <th>Payslip</th>
                                                                        <th class="text-right">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${listSalary}" var="lists">
                                                                        <tr>
                                                                            <td>
                                                                                <img class="rounded-circle"
                                                                                    src="assets/img/${lists.image}"
                                                                                    height="28" width="28" alt="">
                                                                                ${lists.ename}
                                                                            </td>
                                                                            <td>${lists.employeeId}</td>
                                                                            <td><a href="http://cdn-cgi/l/email-protection"
                                                                                    class="__cf_email__"
                                                                                    data-cfemail="305a5f585e545f55705548515d405c551e535f5d"></a>${lists.email}
                                                                            </td>
                                                                            <td>${lists.hireDate}</td>
                                                                            <td>${lists.dname} </td>
                                                                            <td>$${lists.totalSalary}</td>

                                                                            <td><a class="btn btn-sm btn-primary"
                                                                                    href="ViewSalary?id=${lists.salaryId}">Generate
                                                                                    Slip</a></td>

                                                                            <td class="text-right">
                                                                                <div class="dropdown dropdown-action">
                                                                                    <a href="#"
                                                                                        class="action-icon dropdown-toggle"
                                                                                        data-toggle="dropdown"
                                                                                        aria-expanded="false"><i
                                                                                            class="fa fa-ellipsis-v"></i></a>
                                                                                    <div
                                                                                        class="dropdown-menu dropdown-menu-right">
                                                                                        <a class="dropdown-item"
                                                                                            href="UpdateSalary?id=${lists.salaryId}"><i
                                                                                                class="fa fa-pencil m-r-5"></i>
                                                                                            Edit</a>
                                                                                        <a class="dropdown-item"
                                                                                            href="#" data-toggle="modal"
                                                                                            onclick="doDelete('${lists.salaryId}')"><i
                                                                                                class="fa fa-trash-o m-r-5"></i>
                                                                                            Delete</a>
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
                                        <div id="delete_salary" class="modal fade delete-modal" role="dialog">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-body text-center">
                                                        <img src="assets/img/sent.png" alt="" width="50" height="46">
                                                        <h3>Are you sure want to delete this Salary?</h3>
                                                        <div class="m-t-20"> <a href="#" class="btn btn-white"
                                                                data-dismiss="modal">Close</a>
                                                            <button type="submit" class="btn btn-danger">Delete</button>
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
                                    window.location = "DeleteSalary?id=" + id;
                                }
                            }
                        </script>
                </body>

                </html>