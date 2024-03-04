<%@ page import="models.AccountDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Preclinic - Medical & Hospital - Bootstrap 4 Admin Template</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->
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

            <c:set var="detail" value="${requestScope.app}"></c:set>

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
                                                        <span class="mail-view-title">${detail.title}</span>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="sender-info">
                                            <div class="sender-img">
                                                <img width="40" alt="" src="assets/img/user.jpg" class="rounded-circle">
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
                                        <p>${detail.content}</p>

                                    </div>
                                </div>
                                <div class="mail-attachments">
                                    <p><i class="fa fa-paperclip"></i>  Attachments -  | <a href="#">Download all</a></p>
                                    <ul class="attachments clearfix text-center">
                                        <li>
                                            <div class="attach-file"><i class="fa fa-file-pdf-o"></i></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">daily_meeting.pdf</a>
                                                <div class="attach-fileize"> 842 KB</div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="attach-file"><i class="fa fa-file-word-o"></i></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">documentation.docx</a>
                                                <div class="attach-fileize"> 2,305 KB</div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="attach-file"><img src="assets/img/placeholder.jpg" alt="Attachment"></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">webdesign.png</a>
                                                <div class="attach-fileize"> 1.42 MB</div>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="attach-file"><img src="assets/img/placeholder.jpg" alt="Attachment"></div>
                                            <div class="attach-info">
                                                <a href="#" class="attach-filename">webdevelopment.png</a>
                                                <div class="attach-fileize"> 1.1 MB</div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                    <hr>
                                    <br>
                                    <br>
                                    <c:choose>
                                    <c:when test="${empty detail.complete_date}">
                                    <div class="mailview-footer">
                                        <div class="row">
                                            <% if(request.getAttribute("thongbao")!=null) { %>
                                            <div class="col-sm-6 right-action">
                                                <span style="color: #1E824C; font-size: 16px; font-weight: bold;">Delete Successfully</span>
                                            </div>
                                            <div class="col-sm-6 right-action">
                                                <button type="button" class="btn btn-white" onclick="refreshPage()"><i class="fa fa-refresh"></i> Refresh</button>
                                            </div>
                                            <% } %>

                                            <%
                                                AccountDTO account = (AccountDTO) request.getSession().getAttribute("account");
                                                if (account.getRole() == 3) {
                                            %>
                                            <div class="col-sm-6 left-action">
                                                <button id="reply-btn" type="button" class="btn btn-white"><i class="fa fa-reply"></i> Reply</button>
                                            </div>
                                            <% } %>

                                            <%
                                                if (account.getRole() == 2) {
                                            %>
                                            <div class="col-sm-6 right-action">
                                                <button type="button" class="btn btn-white" onclick="confirmDelete(${detail.application_id})"><i class="fa fa-trash-o"></i> Delete</button>
                                            </div>
                                            <% } %>
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
                                                <img width="40" alt="" src="assets/img/user.jpg" class="rounded-circle">
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
                <div class="notification-box">
                    <div class="msg-sidebar notifications msg-noti">
                        <div class="topnav-dropdown-header">
                            <span>Messages</span>
                        </div>
                        <div class="drop-scroll msg-list-scroll" id="msg_list">
                            <ul class="list-box">
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">R</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Richard Miles </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item new-message">
                                            <div class="list-left">
                                                <span class="avatar">J</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">John Doe</span>
                                                <span class="message-time">1 Aug</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">T</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Tarah Shropshire </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">M</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Mike Litorus</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">C</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Catherine Manseau </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">D</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Domenic Houston </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">B</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Buster Wigton </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">R</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Rolland Webber </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">C</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author"> Claire Mapes </span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">M</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Melita Faucher</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">J</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Jeffery Lalor</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">L</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Loren Gatlin</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="chat.html">
                                        <div class="list-item">
                                            <div class="list-left">
                                                <span class="avatar">T</span>
                                            </div>
                                            <div class="list-body">
                                                <span class="message-author">Tarah Shropshire</span>
                                                <span class="message-time">12:28 AM</span>
                                                <div class="clearfix"></div>
                                                <span class="message-content">Lorem ipsum dolor sit amet, consectetur adipiscing</span>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="topnav-dropdown-footer">
                            <a href="chat.html">See all messages</a>
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
                // Chuyển hướng đến servlet khác
                window.location.href = "viewsendapplication";
            }
            document.getElementById("reply-btn").addEventListener("click", function() {
                document.getElementById("reply-form").style.display = "block";
            });


        </script>


    </body>

</html>
