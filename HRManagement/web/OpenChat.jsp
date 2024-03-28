<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<%@ page import="dal.ApplicationDAO" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

    <title>Preclinic - Medical & Hospital - Bootstrap 4 Admin Template</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <!--[if lt IE 9]>
    <script src="assets/js/html5shiv.min.js"></script>
    <script src="assets/js/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<%
    ApplicationDAO ad= new ApplicationDAO();
    AccountDTO acc = (AccountDTO) session.getAttribute("account");
    int role=     acc.getRole();
    int sender_id= ad.GetEmployeeIDbyUserID(acc);
    String sender_name=ad.getNamebyAccount(acc);
    String sender_image=ad.getImagebyAccount(acc);
%>
<c:set var="em" value="${requestScope.emp}" />
<div class="main-wrapper">
        <% if (role == 2) { %>
    <jsp:include page="SideBarforEm.jsp" />
        <% } else if (role == 3|| role == 1) { %>
    <jsp:include page="BarMessageForAdmin.jsp" />
        <% } %>
    <div class="main-wrapper">
        <div class="sidebar" id="sidebar">
            <div class="sidebar-inner slimscroll">
                <div class="sidebar-menu">
                    <ul>
                        <% if (role == 2) { %>
                                <li>
                                    <a href="HomeEmployees">Back</a>
                                </li>
                                <% } else if (role == 3||role==1) { %>
                                <li>
                                    <a href="dashboard">Back</a>
                                </li>
                                <% } %>
                        <li>
                            <a href="OpenChat">All</a>
                        </li>



                    </ul>
                </div>
            </div>
        </div>
        <div class="page-wrapper">
            <div class="chat-main-row">
                <div class="chat-main-wrapper">
                    <div class="col-lg-9 message-view chat-view">
                        <div class="chat-window">
                            <div class="fixed-header">
                                <div class="navbar">
                                    <div class="user-details mr-auto">
                                        <div class="float-left user-img m-r-10">
                                            <a href="profile.html" title="Jennifer Robinson"><img src="assets/img/user.jpg" alt="" class="w-40 rounded-circle"><span class="status online"></span></a>
                                        </div>
                                        <div class="user-info float-left">
                                            <a href="profile.html"><span class="font-bold">All</span> <i class="typing-text"></i></a>

                                        </div>
                                    </div>


                                </div>
                            </div>
                            <div class="chat-contents">
                                <div class="chat-content-wrap">
                                    <div class="chat-wrap-inner">
                                        <div class="chat-box">
                                            <div class="chats" id="chat-body">
                                                <c:forEach items="${requestScope.listAllMessageinaConversation}" var="message">
                                                    <c:choose>
                                                        <c:when test="${message.sender_id eq currentId}">
                                                            <div class="chat chat-right">
                                                                <div class="chat-body">
                                                                    <div class="chat-bubble">
                                                                        <div class="chat-content">
                                                                            <span class="chat-time">${message.sender}</span>
                                                                            <p>${message.content}</p>
                                                                            <span class="chat-time">${message.formatTime}</span>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="chat chat-left">
                                                                <div class="chat-avatar">
                                                                    <a href="profile.html#" class="avatar">
                                                                        <img alt="Jennifer Robinson" src="assets/img/avatar/${message.sender_image}" class="img-fluid rounded-circle">
                                                                    </a>
                                                                </div>
                                                                <div class="chat-body">
                                                                    <div class="chat-bubble">
                                                                        <div class="chat-content">
                                                                            <span class="chat-time">${message.sender}</span>
                                                                            <p>${message.content}</p>
                                                                            <span class="chat-time">${message.formatTime}</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="chat-footer">
                                <div class="message-bar">
                                    <div class="message-inner">
                                        <div class="message-area">
                                            <div class="input-group">

                                                <textarea id="textMessage" class="form-control" placeholder="Please Message" name="content" required=""></textarea>
                                                <input id="sender_id" type="hidden" value="<%=  (int)sender_id %>">
                                                <input id="sender_name" type="hidden" value="<%= (String)sender_name %>">
                                                <input id="sender_image" type="hidden" value="<%= (String)sender_image %>">
                                                <span class="input-group-append">
                                                            <button onclick="send()" class="btn btn-primary" type="button"><i class="fa fa-send"></i></button>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>

            <div id="drag_files" class="modal fade" role="dialog">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Drag and drop files upload</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form id="js-upload-form">
                                <div class="upload-drop-zone" id="drop-zone">
                                    <i class="fa fa-cloud-upload fa-2x"></i> <span class="upload-text">Just drag and drop files here</span>
                                </div>
                                <h4>Uploading</h4>
                                <ul class="upload-list">
                                    <li class="file-list">
                                        <div class="upload-wrap">
                                            <div class="file-name">
                                                <i class="fa fa-photo"></i> photo.png
                                            </div>
                                            <div class="file-size">1.07 gb</div>
                                            <button type="button" class="file-close">
                                                <i class="fa fa-close"></i>
                                            </button>
                                        </div>
                                        <div class="progress progress-xs progress-striped">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 65%"></div>
                                        </div>
                                        <div class="upload-process">37% done</div>
                                    </li>
                                    <li class="file-list">
                                        <div class="upload-wrap">
                                            <div class="file-name">
                                                <i class="fa fa-file"></i> task.doc
                                            </div>
                                            <div class="file-size">5.8 kb</div>
                                            <button type="button" class="file-close">
                                                <i class="fa fa-close"></i>
                                            </button>
                                        </div>
                                        <div class="progress progress-xs progress-striped">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 65%"></div>
                                        </div>
                                        <div class="upload-process">37% done</div>
                                    </li>
                                    <li class="file-list">
                                        <div class="upload-wrap">
                                            <div class="file-name">
                                                <i class="fa fa-photo"></i> dashboard.png
                                            </div>
                                            <div class="file-size">2.1 mb</div>
                                            <button type="button" class="file-close">
                                                <i class="fa fa-close"></i>
                                            </button>
                                        </div>
                                        <div class="progress progress-xs progress-striped">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 65%"></div>
                                        </div>
                                        <div class="upload-process">Completed</div>
                                    </li>
                                </ul>
                            </form>
                            <div class="m-t-30 text-center">
                                <button class="btn btn-primary submit-btn">Add to upload</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="add_group" class="modal fade">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Create a group</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>Groups are where your team communicates. They?re best when organized around a topic ? #leads, for example.</p>
                            <form action="AddConversation">
                                <div class="form-group">
                                    <label>Group Name <span class="text-danger">*</span></label>

                                    <input class="form-control" type="text" name="GroupName" required="">
                                    <input type="hidden" name="typeConversationID" value="1">
                                </div>

                                <div class="m-t-50 text-center">
                                    <button class="btn btn-primary submit-btn">Create Group</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="add_people" class="modal fade" role="dialog">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Add People to Group Chat</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">

                            <form action="AddPeopletoGroup" method="post">
                                <div>
                                    <h5>People</h5>
                                    <ul class="chat-user-list" style="overflow-y: auto; max-height: 300px;">
                                        <c:forEach items="${requestScope.listEmployeeChat}" var="listEmployeeChat">
                                            <li>
                                                <a href="#" class="user-item">
                                                    <div class="media">
                                                                <span class="avatar align-self-center">
                                                                    <img src="assets/img/user.jpg">
                                                                </span>
                                                        <div class="media-body text-nowrap align-self-center">
                                                            <div class="user-name">${listEmployeeChat.name}</div>
                                                            <span class="designation">${listEmployeeChat.departmentName}</span>
                                                        </div>
                                                        <div class="align-self-center text-nowrap">
                                                            <div class="online-date">
                                                                <input type="checkbox" name="selectedEmployees" value="${listEmployeeChat.employeeId}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <input type="hidden" name="ConverId" value="${ConverId}">
                                <div class="m-t-50 text-center">
                                    <button class="btn btn-primary submit-btn">Add People</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div id="add_chat_user" class="modal fade " role="dialog">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Create Chat Group</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="input-group m-b-30">
                                <input placeholder="Search to start a chat" class="form-control search-input" id="btn-input" type="text">
                                <span class="input-group-append">
                                            <button class="btn btn-primary">Search</button>
                                        </span>
                            </div>
                            <div>
                                <h5>Recent Conversations</h5>
                                <ul class="chat-user-list">
                                    <li>
                                        <a href="#">
                                            <div class="media">
                                                <span class="avatar align-self-center">J</span>
                                                <div class="media-body align-self-center text-nowrap">
                                                    <div class="user-name">Jeffery Lalor</div>
                                                    <span class="designation">Team Leader</span>
                                                </div>
                                                <div class="text-nowrap align-self-center">
                                                    <div class="online-date">1 day ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <div class="media ">
                                                <span class="avatar align-self-center">B</span>
                                                <div class="media-body align-self-center text-nowrap">
                                                    <div class="user-name">Bernardo Galaviz</div>
                                                    <span class="designation">Web Developer</span>
                                                </div>
                                                <div class="align-self-center text-nowrap">
                                                    <div class="online-date">3 days ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <div class="media">
                                                        <span class="avatar align-self-center">
                                                            <img src="assets/img/user.jpg" alt="John Doe">
                                                        </span>
                                                <div class="media-body text-nowrap align-self-center">
                                                    <div class="user-name">John Doe</div>
                                                    <span class="designation">Web Designer</span>
                                                </div>
                                                <div class="align-self-center text-nowrap">
                                                    <div class="online-date">7 months ago</div>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="m-t-50 text-center">
                                <button class="btn btn-primary submit-btn">Create Group</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="share_files" class="modal fade" role="dialog">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">Share File</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="files-share-list">
                                <div class="files-cont">
                                    <div class="file-type">
                                        <span class="files-icon"><i class="fa fa-file-pdf-o"></i></span>
                                    </div>
                                    <div class="files-info">
                                        <span class="file-name text-ellipsis">AHA Selfcare Mobile Application Test-Cases.xls</span>
                                        <span class="file-author"><a href="#">Bernardo Galaviz</a></span> <span class="file-date">May 31st at 6:53 PM</span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Share With</label>
                                <input class="form-control" type="text">
                            </div>
                            <div class="m-t-50 text-center">
                                <button class="btn btn-primary submit-btn">Share</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           
        </div>
    </div>
    <div class="sidebar-overlay" data-reff=""></div>
    <script type="text/javascript">
        const chatElement = document.getElementById('chat-body');
        const ws = new WebSocket("ws://localhost:9999/HRManagement/chatRoomServer");

        ws.onopen = function () {
            console.log('Web Socket connection established');
        };

        ws.onmessage = function (event) {
            console.log(event);
            const message = JSON.parse(event.data);
            const sender_id = document.getElementById("sender_id").value;
            const date = new Date(message.timestamp);
            console.log(message);
            const currentDate = new Date();
            const currentDay = currentDate.getDate();
            const currentMonth = currentDate.getMonth() + 1; // Tháng b?t ??u t? 0 nên c?n c?ng thêm 1

            const messageDay = date.getDate();
            const messageMonth = date.getMonth() + 1;

            let formattedTime;
            if (currentDay === messageDay && currentMonth === messageMonth) {
                // ??nh d?ng gi? và phút t? ??i t??ng Date
                const hours = date.getHours();
                const minutes = date.getMinutes();
                formattedTime = hours.toString().padStart(2, '0') + ':' + minutes.toString().padStart(2, '0'); // ??nh d?ng gi?:phút
            } else {
                // N?u khác ngày g?i, hi?n th? ngày và tháng c?a tin nh?n
                formattedTime = messageDay.toString().padStart(2, '0') + '/' + messageMonth.toString().padStart(2, '0');
            }

            const chat = document.createElement('div');

            if (message.sender_id.toString() === sender_id) {
                const test = 1;
                chat.innerHTML = `
            <div class="chat chat-right">
                <div class="chat-body">
                    <div class="chat-bubble">
                        <div class="chat-content">
                            <span class="chat-time">` + message.sender_name + ` </span>
                            <p>` + message.content + `</p>
                            <span class="chat-time">` + formattedTime + ` </span>
                        </div>
                    </div>
                </div>
            </div>
        `;
            } else {
                chat.innerHTML = `
            <div class="chat chat-left">
                <div class="chat-avatar">
                    <a href="profile.html#" class="avatar">
                        <img alt="${message.sender_name}" src="assets/img/avatar/` + message.sender_image + `" class="img-fluid rounded-circle">
                    </a>
                </div>
                <div class="chat-body">
                    <div class="chat-bubble">
                        <div class="chat-content">
                            <span class="chat-time">` + message.sender_name + ` </span>
                            <p>` + message.content + `</p>
                            <span class="chat-time">` + formattedTime + ` </span>
                        </div>
                    </div>
                </div>
            </div>
        `;
            }
            chatElement.appendChild(chat);
            scrollToBottom();
        };

        ws.onclose = function () {
            console.log('WebSocket connection closed');
        };

        ws.onerror = function (error) {
            console.log('Error occurred:', error);
        };

        function scrollToBottom() {
            chatElement.scrollTop = chatElement.scrollHeight;
        }

//        function send() {
//            const sender_id = document.getElementById("sender_id").value;
//            const sender_name = document.getElementById("sender_name").value;
//            const content = document.getElementById("textMessage").value;
//            const timestamp = Date.now();
//
//            if (content.trim() === '') {
//                alert('Please enter a message');
//                return;
//            }
//
//            const json = {
//                'sender_id': sender_id,
//                'content': content,
//                'timestamp': timestamp,
//                'sender_name': sender_name
//            };
//
//            // G?i d? li?u JSON qua WebSocket
//            ws.send(JSON.stringify(json));
//        }
function send() {
    const sender_id = document.getElementById("sender_id").value;
    const sender_name = document.getElementById("sender_name").value;
    const content = document.getElementById("textMessage").value;
    const timestamp = Date.now();
    const sender_image=document.getElementById("sender_image").value;

    if (content.trim() === '') {
        alert('Please enter a message');
        return;
    }

    // Thay th? c?c d?u '<' v? '>' trong n?i dung b?ng c?c th? HTML t??ng ?ng
    const sanitizedContent = sanitizeInput(content);

    const json = {
        'sender_id': sender_id,
        'content': sanitizedContent,
        'timestamp': timestamp,
        'sender_name': sender_name,
        'sender_image': sender_image
    };

    // G?i d? li?u JSON qua WebSocket
    ws.send(JSON.stringify(json));
    clearInput();
}

// H?m ?? thay th? '<' v? '>' b?ng c?c th? HTML t??ng ?ng
function sanitizeInput(input) {
    return input.replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
function clearInput() {
    document.getElementById("textMessage").value = '';
}

    </script>


    <script src="assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/jquery.slimscroll.js"></script>
    <script src="assets/js/app.js"></script>
</body>

</html>