<%-- 
    Document   : department
    Created on : Jan 14, 2024, 10:53:39 AM
    Author     : ThuyVy
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap CSS -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="assets/css/main.css" rel="stylesheet">
        <title>Department</title>
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

        <!--Menu ben trai-->
        <div class="container-fluid mt-3">
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
                            <button type="button" class="btn btn-success" style="margin: 10px 0 ;">
                                <a style="text-decoration: none" href="addDep">Add new Department</a>
                            </button>
                        </section>
                        <div class="main">
                            <div class="main-text-header">
                                <h5>DataTables Deparment</h5>
                            </div>
                            <div class="main-option">
                               
                                <div class="main-option-search">
                                    <nav class="navbar navbar-light bg-light justify-content-between">

                                        <form action="department" method="get" class="form-inline">
                                            <input class="form-control mr-sm-2" name="search" type="text" placeholder="Search"
                                                   aria-label="Search" style="height: 30px;" >
                                            <button class="btn btn-outline-success my-2 my-sm-0"
                                                    type="submit" style="height: 30px;">Search</button>
                                        </form>
                                    </nav>
                                </div>

                            </div>
                        </div>
                        <!--display information-->
                        <div class="main-option-information-department">
                            <table style=" border: 1px solid black;" class="table table-hover table-bordered">
                                <tr style=" border: 1px solid black;">
                                    <th style=" border: 1px solid black;">Department ID</th>
                                    <th style=" border: 1px solid black;">Department Name</th>
                                    <th style=" border: 1px solid black;">Action</th>
                                </tr>
                                <c:forEach var="o" items="${requestScope.list}">
                                    <tr style=" border: 1px solid black;" class="table_row">
                                        <td style=" border: 1px solid black;" class="column-1">${o.getDepartment_id()}</td>    
                                        <td style=" border: 1px solid black;" class="column-2">${o.getName()}</td>
                                        <td>
                                            <a href="UpdateDepartment?pid=${o.getDepartment_id()}" class="btn btn-success">Update</a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href="DeleteDepartment?pid=${o.getDepartment_id()}" class="btn btn-danger" onclick="doDelete('${o.getDepartment_id()}')">Delete</a>
                                        </td>

                                    </tr>
                                </c:forEach>

                            </table> 


                        </div>
                    </section>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">
        function doDelete(id) {
            if (confirm("Are you sure to delete Department_ID = " + id)) {
                window.location = "DeleteDepartment?pid=" + id;
            }
        }
    </script>
    </body>

</html>