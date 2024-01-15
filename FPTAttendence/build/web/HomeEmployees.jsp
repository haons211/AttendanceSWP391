<%-- 
    Document   : HomeEmployees
    Created on : Jan 11, 2024, 5:44:55 PM
    Author     : NCM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <img src="assets/img/y-nghia-logo-fpt-lan-3.jpg" alt="Company Logo">
                <!-- </div> -->
                <!-- <div class="col text-end"> -->
                <div class="user-info">
                    <p>thuy vy</p>
                    <img src="assets/img/avatar.jpg" alt="Avatar">
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
                    <li class="nav-item"><a id="profile" class="nav-link" href="profile">Thông tin cá nhân</a></li>
                    <li class="nav-item"><a id="application"class="nav-link" href="#">Viết đơn</a></li>
                    <li class="nav-item"><a id="showapplication"class="nav-link" href="#">Xem các đơn đã gửi</a></li>
                    <li class="nav-item"><a id="Nofitication"class="nav-link" href="#">Thông báo</a></li>
                </ul>
            </aside>

            <main class="col-lg-10 col-md-9" >
                <section class="main-content"  >
                    <section class="attendance" id="attendance-content">
                        <h1>Điểm danh</h1>
                        <table>
                            <thead>
                                <tr>
                                    <th>Ngày</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>01/01/2024</td>
                                    <td><button class="btn-check">Check In</button></td>
                                    <td><button class="btn-check-out">Check Out</button></td>
                                    <td>Đã điểm danh</td>
                                </tr>
                                <!-- Thêm các hàng khác tương ứng với ngày điểm danh -->
                            </tbody>
                        </table>

                        <div class="attendance-info">
                            <p>Ngày hôm nay: 01/01/2024</p>
                            <p>Tên người dùng: Username</p>
                            <!-- Thêm thông tin khác nếu cần -->
                        </div>
                    </section>
                    <section class="profile" id="profile-content">
                        <h1>Hồ sơ cá nhân</h1>
                        <div class="profile-container">
                            <div class="profile-image">
                                <img src="assets/img/avatar.jpg" alt="Profile Picture">
                            </div>

                            <div class="profile-info">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td>ID</td>
                                            <td>12345</td>
                                        </tr>
                                        <tr>
                                            <td>Full Name</td>
                                            <td>Người Dùng</td>
                                        </tr>
                                        <tr>
                                            <td>Phone</td>
                                            <td>0123-456-789</td>
                                        </tr>
                                        <tr>
                                            <td>Address</td>
                                            <td>123 Đường ABC, Quận XYZ</td>
                                        </tr>
                                        <tr>
                                            <td>Email</td>
                                            <td>nguoidung@example.com</td>
                                        </tr>
                                        <tr>
                                            <td>Gender</td>
                                            <td>Nam</td>
                                        </tr>
                                        <tr>
                                            <td>Ngày sinh</td>
                                            <td>01/01/1990</td>
                                        </tr>
                                        <tr>
                                            <td>Hire Date</td>
                                            <td>01/01/2022</td>
                                        </tr>
                                    </tbody>
                                </table>

                                <button class="btn-edit-profile">Chỉnh sửa hồ sơ</button>
                            </div>
                        </div>
                    </section>
                    <section class="send-application" id="application-content">
                        <h1>Viết đơn</h1>
                        <div class="application-container" id="request-content">

                            <form class="application-form">
                                <div class="form-group">
                                    <label for="application-type">Application Type:</label>
                                    <select id="application-type" name="applicationType">
                                        <option value="choose">Choose Application Type</option>
                                        <option value="reason">Reason</option>
                                        <!-- Thêm các loại đơn khác nếu cần -->
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
                    <section class="showapplication" id="showapplication-content">
                        <h1>Xem đơn</h1>
                        <div class="application-container">
                            <table class="process-table">
                                <thead>
                                    <tr>
                                        <th>TYPE</th>
                                        <th>PURPOSE</th>
                                        <th>CREATEDATE</th>
                                        <th>PROCESSNOTE</th>
                                        <th>FILE</th>
                                        <th>STATUS</th>
                                        <th>DONE</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Đăng ký thi cải thiện điểm</td>
                                        <td>Em muốn cải thiện điểm FE ạ</td>
                                        <td>02/04/2023</td>
                                        <td>phòng thi BE-202</td>
                                        <td></td>
                                        <td>Approved</td>
                                        <td>
                                            <span>03/04/2023 12:23:43</span>
                                        </td>
                                    </tr>
                                    <!-- Thêm các hàng khác tương ứng -->
                                </tbody>
                            </table>
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
    </body>
</html>
