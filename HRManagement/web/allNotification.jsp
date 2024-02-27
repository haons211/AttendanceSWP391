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
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Notification</h4>
                        </div>
                    </div>
                    <div class="main-option">
                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">
                                <form action="AllNotification" method="POST" class="form-inline">
                                    <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search" aria-label="Search" style="height: 30px;">
                                    
                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;margin-right: 20px;"name="btAction" value="Search">Search</button>
                                    
                                    <label for="fromDate">From:</label>
                                    <input type="date" name="dateFrom" id="fromDate" class="form-control" style="height: 30px;  ">

                                    <label for="toDate">To:</label>
                                    <input type="date" name="dateEnd" id="toDate" class="form-control" style="height: 30px;">

                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;"name="btAction"value="Find">Find</button>

                                </form>
                            </nav>
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
                                        <% if (role == 3||role == 1) { %>
                                            <th></th>
                                            <th></th>
                                             <% } %>

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
                                                 <% if (role == 3||role == 1) { %>
                                                <td class="column-2">  

                                                    <form id="deleteForm_${o.notificationId}" onsubmit="deleteNotification(event, this)">
                                                        <input type="hidden" name="id" value="${o.notificationId}">
                                                        <button class="btn btn-danger delete-btn" type="submit">Delete</button>
                                                    </form>
                                                </td>
                                                <td class="column-2">  

                                                    <form action="editNotification?id=" method="get">
                                                        <input type="hidden" name="id" value="${o.notificationId}">
                                                        <button class="btn btn-primary" type="submit">Edit</button>
                                                    </form>

                                                </td>
                                                <% } %>


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

        <script>


            function deleteNotification(event, form) {
                event.preventDefault();

                var confirmDelete = confirm("B?n c� ch?c ch?n mu?n x�a kh�ng?");
                if (!confirmDelete) {
                    return;
                }



                // L?y gi� tr? c?a input
                var notificationId = form.querySelector('input[name="id"]').value;

                // T?o XMLHttpRequest object
                var xhr = new XMLHttpRequest();

                // X�c ??nh ph??ng th?c v� URL
                xhr.open('GET', 'DeleteNotification?id=' + encodeURIComponent(notificationId), true);

                // X? l� k?t qu? tr? v? t? server
                xhr.onload = function () {
                    if (xhr.status === 200) {


                        alert('?� x�a th�nh c�ng');


            var confirmDelete = confirm("B?n có ch?c ch?n mu?n xóa không?");
            if (!confirmDelete) {
                return;
            }



            // L?y giá tr? c?a input
            var notificationId = form.querySelector('input[name="id"]').value;

            // T?o XMLHttpRequest object
            var xhr = new XMLHttpRequest();

            // Xác ??nh ph??ng th?c và URL
            xhr.open('GET', 'DeleteNotification?id=' + encodeURIComponent(notificationId), true);

            // X? lý k?t qu? tr? v? t? server
            xhr.onload = function () {
                if (xhr.status === 200) {


                    alert('?ã xóa thành công');

                    location.replace(location.origin + location.pathname);
                } else {
                    alert('Có l?i x?y ra');

                }
            }

        }
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const ellipsisLinks = document.querySelectorAll('.ellipsis');
            ellipsisLinks.forEach(link => {
                const parentWidth = link.parentNode.offsetWidth;
                const textWidth = link.offsetWidth;
                if (textWidth > parentWidth) {
                    link.style.maxWidth = (parentWidth - 10) + 'px'; // Tr? ?i 10px ?? ??m b?o kích th??c phù h?p
                }

            });

        </script>






    <div class="sidebar-overlay" data-reff=""></div>
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

