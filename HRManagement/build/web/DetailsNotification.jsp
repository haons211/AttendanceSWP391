<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Dash board employee</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%
               AccountDTO acc = (AccountDTO) session.getAttribute("account");
               int role=     acc.getRole();
        %>
        <c:forEach items="${requestScope.listNo}" var="notification">
            <c:set var="notificationCount" value="${notificationCount + 1}" />
        </c:forEach>
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
                        <c:set var="o" value="${Noti}" />
                         <c:set var="a" value="${Author}" />
                        <div class="col-md-8">
                            <div class="blog-view">
                                <article class="blog blog-single-post">
                                    <h3 class="blog-title">${o.subject}</h3>
                                    <div class="blog-info clearfix">
                                        <div class="post-left">
                                            <ul>
                                                <li><i class="fa fa-calendar"></i> <span>${o.sendTime}</span></li>
                                                <li><i class="fa fa-user-o"></i> <span>${a.name}</span></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="blog-content">
                                        ${o.description}
                                    </div>
                                    <c:if test="${o.inputStream ne null}">
                                        <h3 class="mb-4" id="file">Chick here to Download <a href="Download?id=${o.notificationId}">Download</a></h6>
                                        </c:if>
                                </article>     
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  

        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/Chart.bundle.js"></script>
        <script src="assets/js/chart.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
