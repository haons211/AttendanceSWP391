<%-- 
    Document   : SendApplication
    Created on : Jan 14, 2024, 9:09:58 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="assets/css/main.css" rel="stylesheet">
    <title>Your Website</title>
</head>

    <body>
        <header>
            <div class="container-fluid">
                <div class="row">
                    <!-- <div class="col-auto"> -->
                    <img src="y-nghia-logo-fpt-lan-3.jpg" alt="Company Logo">
                    <!-- </div> -->
                    <!-- <div class="col text-end"> -->
                    <div class="user-info">
                        <p>thuy vy</p>
                        <img src="avatar.jpg" alt="Avatar">
                        <a href="#">Logout</a>
                    </div>
                    <!-- </div> -->
                </div>
            </div>
        </header>

        <div class="container-fluid mt-3">
            <div class="row">
                <aside class="col-lg-2 col-md-3">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a id="attendance" class="nav-link" href="#">Điểm danh</a></li>
                        <li class="nav-item"><a id="profile" class="nav-link" href="#">Thông tin cá nhân</a></li>
                        <li class="nav-item"><a id="application"class="nav-link" href="sendapplication">Viết đơn</a></li>
                        <li class="nav-item"><a id="showapplication"class="nav-link" href="#">Xem các đơn đã gửi</a></li>
                        <li class="nav-item"><a id="Nofitication"class="nav-link" href="#">Thông báo</a></li>
                    </ul>
                </aside>

                <main class="col-lg-10 col-md-9" >
                    <section class="main-content"  >                                   


                        <!-- Send Application -->
                        <section class="send-application" id="application-content">
                            <h1>Viết đơn</h1>
                            <div class="application-container" id="request-content">

                                <form class="application-form" method="post" action="sendapplication" >
                                    <div class="form-group">
                                        <label for="application-type">Application Type:</label>
                                        <select id="application-type" name="applicationType">
                                            <c:forEach items="${requestScope.types_list}" var="tl">
                                                <option value="${tl.type_id}" > ${tl.name}</option>
                                            </c:forEach>
                                            <!-- Thêm các loại đơn khác nếu cần -->
                                        </select>
                                        <label>Manager:</label>
                                        <select name="receiver_id">
                                            <c:forEach items="${requestScope.managers_list}" var="ml">
                                                <option value="${ml.employee_id}" > ${ml.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="reason">Reason:</label>
                                        <textarea id="reason" name="reason" rows="4"
                                                  placeholder="Enter your reason"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="file-attach">File Attach:</label>
                                        <input type="file" id="file-attach" name="fileAttach"
                                               accept=".xlsx, .pdf, .docx, .doc, .xls, .jpg, .png, .zip">
                                        <p>Extension File: "xlsx", "pdf", "docx", "doc", "xls", "jpg", "png", "zip".</p>
                                    </div>
                                    <input type="submit" class="submit-btn" value="Submit">
                                </form>
                            </div>
                        </section>                              
                    </section>
                </main>
            </div>
        </div>

        <footer class="bg-light text-center p-3">
            <p>&copy; 2024 Your Company</p>
        </footer>

        <!-- Bootstrap JS và Popper.js (cần thiết cho một số tính năng của Bootstrap) -->
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/js1.js"></script>
    </body>
</html>
