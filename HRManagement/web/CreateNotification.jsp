<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Send Notification</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
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

                    <div class="container mt-5">
                        <h2 class="mb-4">Send Notification</h2>
                        <form action="ManagerNotification" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="subject">Subject:</label>
                                <input type="text" class="form-control" id="subject" name="subject" required>
                            </div>
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea class="form-control" id="description" name="description" rows="10" style="resize: none;" required></textarea>
                            </div>
                                <label for="file">Choose File:</label>

                                <input class="" type="file" class="form-control-file" id="file" name="file">
                                <small class="form-text text-muted">Max. file size: 20 MB. Allowed images: jpg, zip, png., docx,... </small>


                            <button type="submit" class="btn btn-primary">Send</button>
                        </form>
                    </div>
                    <c:if test="${alert != null}">
                        <c:choose>
                            <c:when test="${alert}">
                                <div class="alert alert-success" role="alert">
                                    Send Notification Successfull!
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-danger" role="alert">
                                    Send Notification Failed. Please try again!!!!
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>  
            </div>
        </div>
    <div class="sidebar-overlay" data-reff=""></div>
    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.slimscroll.js"></script>
    <script src="assets/js/Chart.bundle.js"></script>
    <script src="assets/js/chart.js"></script>
    <script src="assets/js/app.js"></script>

</body>

</html>
