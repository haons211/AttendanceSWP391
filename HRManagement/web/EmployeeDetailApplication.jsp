<%@ page import="models.AccountDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Detail Application</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    </head>

    <body>
        <c:set var="detail" value="${requestScope.app}"></c:set>
        <%
            AccountDTO acc = (AccountDTO) session.getAttribute("account");
            int role= acc.getRole();
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
                        <div class="col-sm-12">
                            <h4 class="page-title">View Application</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card-box">
                                <div class="mailview-content">
                                    <div class="mailview-header">
                                        <div class="row">
                                            <div class="col-sm-9">
                                                <div class="text-ellipsis m-b-10">
                                                    <span class="mail-view-title">Title: ${detail.title}</span>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="sender-info">
                                            <div class="sender-img">
                                                <img width="40" alt="" src="assets/img/avatar/${detail.sender_image}" class="rounded-circle">
                                            </div>
                                            <div class="receiver-details float-left">
                                                <span class="sender-name">${detail.sender_name} (<a href="http://cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="5e3431363034313b1e3b263f332e323b703d3133">[email&#160;protected]</a>)</span>
                                                <span class="receiver-name">
                                                    to <span>${detail.receiver_name}</span>
                                                </span>
                                            </div>
                                            <div class="mail-sent-time">
                                                <span class="mail-time">${detail.create_date}</span>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="mailview-inner">
                                        <p>Content: ${detail.content}</p>

                                    </div>
                                </div>

                                <!--                        <hr>
                                                        <br>
                                                        <br>-->
                                <c:choose>
                                    <c:when test="${empty detail.complete_date}">
                                        <div class="mailview-footer">
                                            <div class="row">


                                                <%
                                                    AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
                                                    if (account.getRole() == 3) {
                                                %>
                                                <div class="col-sm-6 left-action">
                                                    <button id="reply-btn" type="button" class="btn btn-white"><i class="fa fa-reply"></i> Reply</button>
                                                </div>
                                                <% } %>

                                                <%
                                                    if (account.getRole() == 2 ) {
                                                        if(request.getAttribute("thongbao") ==null) {
                                                %>
                                                <div class="col-sm-6 right-action">
                                                    <button type="button" class="btn btn-white" onclick="confirmDelete(${detail.application_id})"><i class="fa fa-trash-o"></i> Delete</button>
                                                </div>
                                                <div class="col-sm-6 right-action">
                                                    <button type="button" class="btn btn-white" data-toggle="modal" data-target="#add_group"> Update</button>
                                                </div>

                                                <% }else if(request.getAttribute("thongbao")!=null){ %>
                                                <div class="col-sm-6 right-action">
                                                    <span style="color: #1E824C; font-size: 16px; font-weight: bold;">Delete Successfully</span>
                                                </div>
                                                <div class="col-sm-6 right-action">
                                                    <button type="button" class="btn btn-white" onclick="refreshPage()"><i class="fa fa-refresh"></i> Refresh</button>
                                                </div>
                                                <% }} %>
                                            </div>
                                        </div>

                                        <br>
                                        <br>
                                        <div id="reply-form" style="display: none;">
                                            <form action="replyapplication" >
                                                <textarea id="content" name="content" rows="4" cols="100" placeholder="Enter content" required=""></textarea>
                                                <input type="hidden" name="application_id" value=${detail.application_id}>
                                                <br>
                                                <input type="submit" value="Done">
                                            </form>
                                        </div>


                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="sender-info">
                                        <div class="sender-img">
                                            <img width="40" alt="" src="assets/img/avatar/${detail.receiver_image}" class="rounded-circle">
                                        </div>
                                        <div class="receiver-details float-left">
                                            <span class="sender-name">${detail.receiver_name} (<a href="http://cdn-cgi/l/email-protection" class="__cf_email__" data-cfemail="5e3431363034313b1e3b263f332e323b703d3133">[email&#160;protected]</a>)</span>
                                            <span class="receiver-name">
                                                to <span>${detail.sender_name}</span>

                                            </span>
                                        </div>
                                        <div class="mail-sent-time">
                                            <span class="mail-time">${detail.complete_date}</span>
                                        </div>
                                        <br>
                                        <br>
                                        <hr>
                                    </div>
                                    <div class="mailview-inner">
                                        <p>${detail.replyContent}</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
            <div id="add_group" class="modal fade">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Update Application</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <
                            <form method="post" action="updateApplication">
                                <div class="form-group">
                                    <label>Title <span class="text-danger"></span></label>
                                    <input class="form-control" name="newTitle" type="text" required="">
                                </div>
                                <div class="form-group">
                                    <label>Content <span class="text-muted-light"></span></label>
                                    <input class="form-control" name="newContent" type="text" required="">
                                </div>
                                <input type="hidden" name="application_id" value=${detail.application_id}>
                                <div class="m-t-50 text-center">
                                    <button class="btn btn-primary submit-btn">Update Application</button>
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
        <script>
                                                        function confirmDelete(applicationId) {
                                                            if (confirm("Do you want to Delete?")) {
                                                                window.location.href = "deleteApplication?application_id=" + applicationId;
                                                            }
                                                        }
        </script>
        <script>
            function refreshPage() {

                window.location.href = "viewsendapplication";
            }
            document.getElementById("reply-btn").addEventListener("click", function () {
                document.getElementById("reply-form").style.display = "block";
            });


        </script>


    </body>

</html>