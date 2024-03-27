<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Preclinic - Medical & Hospital - Bootstrap 4 Admin Template</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <!--[if lt IE 9]>
                    <script src="assets/js/html5shiv.min.js"></script>
                    <script src="assets/js/respond.min.js"></script>
            <![endif]-->
    </head>

    <style>.ellipsis {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
            display: inline-block;
        }</style>
    <body>
        <%
                     AccountDTO acc = (AccountDTO) session.getAttribute("account");
                     int role=     acc.getRole();
        %>

        <c:set var="em" value="${requestScope.emp}" />
        <div class="main-wrapper">
            <% if (role == 2) { %>
            <jsp:include page="SideBarforEm.jsp" />
            <% } else if (role == 3) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <form action="Notification" method="POST">
                    <div class="content">
                        <div class="row">
                            <div class="col-12">
                                <h1 class="page-title" style="text-align: center">Notification</h1>
                            </div>
                        </div>
                        <div class="main-option">
                            <div class="main-option-search">
                                <nav class="navbar navbar-light bg-light justify-content-between">

                                    <div class="form-group mr-sm-2 flex-grow-1">
                                        <label for="fromDate">Search:</label>
                                        <input class="form-control w-100" name="search" type="text" placeholder="Search" aria-label="Search" style="height: 30px;">
                                    </div>
                                    <div class="form-group mr-sm-2" style="margin-top: 25px">
                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;"name="btAction" value="Search">Search</button>
                                    </div>
                                    <div class="form-group mr-sm-2">
                                        <label for="fromDate">From:</label>
                                        <input type="date" name="dateFrom" id="fromDate" class="form-control" style="height: 30px;  ">
                                    </div>
                                    <div class="form-group mr-sm-2">
                                        <label for="toDate">To:</label>
                                        <input type="date" name="dateEnd" id="toDate" class="form-control" style="height: 30px;">
                                    </div>
                                    <div class="form-group mr-sm-2"style="margin-top: 25px">
                                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;"name="btAction"value="Find">Find</button>
                                    </div>
                                    </form>
                                </nav>


                            </div>
                        </div>
                </form>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped custom-table mb-0 datatable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Time </th>
                                        <th>Subject</th>
                                        <th>Description</th>
                                        <th class="text-right">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${listNo1}" varStatus="loop">
                                        <tr class="table_row">
                                            <td  class="column-1">${loop.index + 1}</td>    
                                            <td  class="column-1">${o.sendTime}</td>
                                            <td class="column-2">
                                                <a class="ellipsis" href="NotificationDetail?id=${o.notificationId}" title="${o.subject}">${o.subject}</a>
                                            </td>
                                            <td class="column-2">
                                                ${o.description}</a>
                                            </td>

                                            <td class="text-right">
                                                <div class="dropdown dropdown-action">
                                                    <a href="#" class="action-icon dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-ellipsis-v"></i></a>
                                                    <div class="dropdown-menu dropdown-menu-right">
                                                        <a class="dropdown-item" href="editNotification?id=${o.notificationId}"><i class="fa fa-pencil m-r-5"></i> Edit</a>
                                                        <a class="dropdown-item" href="#" onclick="confirmDelete('${o.notificationId}');"><i class="fa fa-trash-o m-r-5"></i> Delete</a>
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
    <script>
        function confirmDelete(notificationId) {
            // Hi?n th? h?p tho?i xác nh?n
            if (confirm('Are you sure you want to delete this notification?')) {
                // N?u ng??i dùng nh?n OK, chuy?n h??ng ??n trang xóa v?i tham s? notificationId
                window.location.href = 'DeleteNotification?id=' + notificationId;
            }
        }
    </script>
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