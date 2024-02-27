<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Edit Account</title>
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
                            <h4 class="page-title">Edit Account</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">
                        </div>

                        <div class="main">
                            <a href="account">
                                <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;">Back</button>
                            </a>

                            <form action="updateAccount" method="post">
                                <div class="mb-3">
                                    <label for="accountId" class="form-label">Account ID</label>
                                    <input type="text" class="form-control" id="accountId" name="accountId" value="${account.userID}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="username" class="form-label">UserName</label>
                                    <input type="text" class="form-control" id="username" name="username" value="${account.userName}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <div class="mb-3">
                                    <label for="repass" class="form-label">Confirm password</label>
                                    <input type="password" class="form-control" id="repass" name="repass" required>
                                </div>
                                <div class="mb-3">
                                    <label for="role" class="form-label">Role</label>
                                    <select name="role" class="form-control" aria-label="Default select example">
                                        <option ${account.role == 1 ? 'selected' : ''}>Admin</option>
                                        <option ${account.role == 2 ? 'selected' : ''}>Manager</option>
                                        <option ${account.role == 3 ? 'selected' : ''}>Employee</option>
                                    </select>
                                </div>

                                <div class="add-to-system">
                                    <button type="submit" class="btn btn-success" style="margin: 10px 0 ;">Update Account</button>
                                </div>
                            </form>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Error! </strong>${errorMessage}
                                </div>
                            </c:if>

                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <strong>Success! </strong> ${successMessage}
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

