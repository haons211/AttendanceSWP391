<%-- 
    Document   : addDepartment
    Created on : Jan 14, 2024, 11:06:54 AM
    Author     : ThuyVy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
</head>

<body>
    <header>
        <div class="container-fluid">
            <div class="row">
                <!-- <div class="col-auto"> -->
                <img src="assets/img/company_logo.png" alt="Company Logo">
                <!-- </div> -->
                <!-- <div class="col text-end"> -->
                <div class="user-info">
                    <p>username</p>
                    <img src="assets/img/avatar.jpg" alt="Avatar">
                    <a href="#">Logout</a>
                </div>
                <!-- </div> -->
            </div>
        </div>
    </header>
    <div class="container-fluid mt-3">
        <!--phan ben trai-->
        <div class="row">
            <aside class="col-lg-2 col-md-3">
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link" href="#">Điểm danh</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Viết đơn</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Thông tin cá nhân</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Phòng ban</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Báo cáo</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Thông báo</a></li>
                </ul>
            </aside>
            <!--Deparment in4-->
            <main class="col-lg-10 col-md-9">
                <section class="main-content">
                    <section class="main-content text">
                        <h1>Deparment</h1>
                        <!--button back-->
                        
                        <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;"><a href="department" style="text-decoration: none">Back</a></button>
                    </section>
                    <div class="main">
                        <div class="main-text-header">
                            <h3> Deparment master data</h3>
                        </div>
                        <div class="main-option-text1">
                            <h4>Add new Deparment</h4>
                        </div>
                        <div class="main-option-text2">
                            <h5>Form to add new deparment to system</h5>
                        </div>
                    
                    <!--form input information-->
                        <form action="addDep" method="post">
                            <div class="input1">
                                <h4>Deparment ID</h4>
                                <input type="text" name="deparmentID" style="width: 400px; height: 40px;">
                            </div>
                            <div class="input1">
                                <h4>Deparment Name</h4>
                                <input type="text" name="deparmentName" style="width: 400px; height: 40px;">
                            </div>
                            <div class="add-to-system">
                                <button type="submit" class="btn btn-success" style="margin: 10px 0 ;">Add to system</button>
                            </div>
                            
                        </form>
                        
                    </div>
                </section>
            </main>
        </div>
    </div>
    
    
    

    <!-- Bootstrap JS và Popper.js (cần thiết cho một số tính năng của Bootstrap) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
