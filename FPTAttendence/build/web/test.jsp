<%-- 
    Document   : test
    Created on : Jan 13, 2024, 3:04:29 PM
    Author     : ThuyVy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/main.css" rel="stylesheet">
    <title>Your Website</title>
</head>

<body>
    <header>
        <div class="container-fluid">
            <div class="row">
                <!-- <div class="col-auto"> -->
                <img src="company_logo.png" alt="Company Logo">
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
                    <li class="nav-item"><a class="nav-link" href="#">Điểm danh</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Viết đơn</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Xem đơn</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Thông tin cá nhân</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Phòng ban</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Báo cáo</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Thông báo</a></li>
                </ul>
            </aside>

            <main class="col-lg-10 col-md-9">
                <section class="main-content">
                    
                    <section class="main-content notification">
                        <h1>LIST NEWS</h1>
                        <ul class="notification-list">
                            <li class="notification-item"><a href="#" onclick="showDetails(this)">Title 1</a></li>
                            <li class="notification-item"><a href="#" onclick="showDetails(this)">Title 2</a></li>
                            <li class="notification-item"><a href="#" onclick="showDetails(this)">Title 3</a></li>
                            <li class="notification-item"><a href="#" onclick="showDetails(this)">Title 4</a></li>
                            <li class="notification-item"><a href="#" onclick="showDetails(this)">Title 5</a></li>
                        </ul>
                        <span class="more-btn" >More</span>
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
