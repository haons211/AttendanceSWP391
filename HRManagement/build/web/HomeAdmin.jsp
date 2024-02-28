<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Admin Dashboard</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <!--[if lt IE 9]>
                    <script src="assets/js/html5shiv.min.js"></script>
                    <script src="assets/js/respond.min.js"></script>
            <![endif]-->
        <%@ page import="java.util.Map" %>
        <%@ page import="java.util.HashMap" %>

        <%
            // Assuming departmentEmployeeCount is available as a request attribute
            Map<String, Integer> departmentEmployeeCount = (Map<String, Integer>) request.getAttribute("departmentEmployeeCount");
        %>
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
                    <div class="row">
                        <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                            <div class="dash-widget">
                                <span class="dash-widget-bg1"><i class="fa fa-home" aria-hidden="true"></i></span>
                                <div class="dash-widget-info text-right">
                                    <h3>${numberDepartments}</h3>
                                    <span class="widget-title1">Departments <i class="fa fa-check" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                            <div class="dash-widget">
                                <span class="dash-widget-bg2"><i class="fa fa-user-o"></i></span>
                                <div class="dash-widget-info text-right">
                                    <h3>${numberEmployees}</h3>
                                    <span class="widget-title2">Employees <i class="fa fa-check" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                            <div class="dash-widget">
                                <span class="dash-widget-bg3"><i class="fa fa-calendar-check-o" aria-hidden="true"></i></span>
                                <div class="dash-widget-info text-right">
                                    <h3>${numberAttend}</h3>
                                    <span class="widget-title3">Attend <i class="fa fa-check" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                            <div class="dash-widget">
                                <span class="dash-widget-bg4"><i class="fa fa-calendar-times-o" aria-hidden="true"></i></span>
                                <div class="dash-widget-info text-right">
                                    <h3>${numberLeave}</h3>
                                    <span class="widget-title4">Leaves <i class="fa fa-check" aria-hidden="true"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-6 col-xl-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="chart-title">
                                    <h4>Employee By Department</h4>
                                </div>	
                                <canvas id="myDoughnutChart" width="400" height="400"></canvas>
                                <script>
                                    // Khai báo bi?n departmentData bên ngoài vòng l?p
                                    var departmentData = {
                                        labels: [],
                                        datasets: [{
                                                data: [],
                                                backgroundColor: [
                                                    'rgb(255, 99, 132)',
                                                    'rgb(54, 162, 235)',
                                                    'rgb(255, 205, 86)',
                                                    'rgb(75, 192, 192)',
                                                    'rgb(153, 102, 255)',
                                                    'rgb(255, 159, 64)',
                                                    'rgb(255, 77, 77)',
                                                    'rgb(92, 184, 92)',
                                                    'rgb(240, 173, 78)',
                                                    'rgb(112, 146, 190)',
                                                    'rgb(217, 83, 79)',
                                                    'rgb(54, 162, 235)',
                                                    'rgb(183, 55, 156)',
                                                    'rgb(64, 191, 128)',
                                                    'rgb(255, 184, 82)',
                                                    'rgb(70, 130, 180)',
                                                    'rgb(0, 128, 0)',
                                                    'rgb(255, 20, 147)'
                                                ]
                                            }]
                                    };

                                    <c:forEach var="entry" items="${listDepartmentEmployee}">
                                    var departmentName = "${entry.departmentName}";
                                    var employeeCount = ${entry.employeeCount};
                                    departmentData.labels.push(departmentName);
                                    departmentData.datasets[0].data.push(employeeCount);
                                    </c:forEach>
                                    // L?y th? canvas ?? v? bi?u ??
                                    var ctx = document.getElementById('myDoughnutChart').getContext('2d');

                                    // T?o bi?u ?? doughnut
                                    var myDoughnutChart = new Chart(ctx, {
                                        type: 'doughnut',
                                        data: departmentData,
                                        options: {
                                            // Tùy ch?n khác có th? ???c thêm vào ? ?ây
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-6 col-xl-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="chart-title">
                                    <h4>Attendance By Department</h4>
                                    <div class="float-right">
                                        <ul class="chat-user-total">      
                                        </ul>
                                    </div>
                                </div>	
                                <canvas id="myBarChart" width="400" height="400"></canvas>

                                <script>
                                    var attendanceData = {
                                        labels: [],
                                        datasets: [{
                                                label: ["%"],
                                                data: [],
                                                backgroundColor: [
                                                    'rgb(255, 99, 132)',
                                                    'rgb(54, 162, 235)',
                                                    'rgb(255, 205, 86)',
                                                    'rgb(75, 192, 192)',
                                                    'rgb(153, 102, 255)',
                                                    'rgb(255, 159, 64)',
                                                    'rgb(255, 77, 77)',
                                                    'rgb(92, 184, 92)',
                                                    'rgb(240, 173, 78)',
                                                    'rgb(112, 146, 190)',
                                                    'rgb(217, 83, 79)',
                                                    'rgb(54, 162, 235)',
                                                    'rgb(183, 55, 156)',
                                                    'rgb(64, 191, 128)',
                                                    'rgb(255, 184, 82)',
                                                    'rgb(70, 130, 180)',
                                                    'rgb(0, 128, 0)',
                                                    'rgb(255, 20, 147)'
                                                ],
                                                borderColor: [
                                                    'rgb(255, 99, 132)',
                                                    'rgb(54, 162, 235)',
                                                    'rgb(255, 205, 86)',
                                                    'rgb(75, 192, 192)',
                                                    'rgb(153, 102, 255)',
                                                    'rgb(255, 159, 64)',
                                                    'rgb(255, 77, 77)',
                                                    'rgb(92, 184, 92)',
                                                    'rgb(240, 173, 78)',
                                                    'rgb(112, 146, 190)',
                                                    'rgb(217, 83, 79)',
                                                    'rgb(54, 162, 235)',
                                                    'rgb(183, 55, 156)',
                                                    'rgb(64, 191, 128)',
                                                    'rgb(255, 184, 82)',
                                                    'rgb(70, 130, 180)',
                                                    'rgb(0, 128, 0)',
                                                    'rgb(255, 20, 147)'
                                                ],
                                                borderWidth: 1
                                            }]
                                    };
                                    <c:forEach var="entry" items="${departmentAttendanceList}">
                                    var departmentName = "${entry.departmentName}";
                                    var attendancePercentage = ${entry.attendancePercentage};
                                    attendanceData.labels.push(departmentName);
                                    attendanceData.datasets[0].data.push(attendancePercentage);
                                    </c:forEach>
                                    var ctxBar = document.getElementById('myBarChart').getContext('2d');

                                    var myBarChart = new Chart(ctxBar, {
                                        type: 'bar',
                                        data: attendanceData,
                                        options: {
                                            scales: {
                                                yAxes: [{
                                                        ticks: {
                                                            beginAtZero: true
                                                        }
                                                    }]
                                            },
                                            legend: {
                                                display: false // ?n nhãn c?a bi?u ??
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>       
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-8 col-xl-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title d-inline-block">Departments</h4> <a href="department" class="btn btn-primary float-right">View all</a>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table mb-0">
                                        <thead class="title-list-department">
                                            <tr>
                                                <th>Department Code</th>
                                                <th>Department Name</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listDepartment}" var="o">
                                                <tr>
                                                    <td style="min-width: 200px;">   
                                                        <h2>${o.dep_code}</h2>
                                                    </td>                 
                                                    <td>
                                                        <h5 class="time-title p-0">${o.name}</h5>                                                   
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 col-lg-4 col-xl-4">
                        <div class="card member-panel">
                            <div class="card-header bg-white">
                                <h4 class="card-title mb-0">Leaves List</h4>
                            </div>
                            <div class="card-body">
                                <ul class="contact-list">
                                    <c:forEach items="${listLeave}" var="a">
                                        <li>
                                            <div class="contact-cont">

                                                <div class="float-left user-img m-r-10">
                                                    <a href="#" title=${a.name}><img src=${a.image} alt="" class="w-40 rounded-circle"><span class="status offline"></span></a>
                                                </div>
                                                <div class="contact-info">
                                                    <span class="contact-name text-ellipsis">${a.name}</span>
                                                    <span class="contact-date">${a.email}</span>
                                                </div>
                                            </div>
                                        </li> 
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="card-footer text-center bg-white">
                                <a href="#" class="text-muted">View attendance report</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-8 col-xl-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title d-inline-block">New Employees </h4> <a href="employee" class="btn btn-primary float-right">View all</a>
                            </div>
                            <div class="card-block">
                                <div class="table-responsive">
                                    <table class="table mb-0 new-patient-table">
                                        <thead class="title-list-department">
                                            <tr>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Phone Number</th>
                                                <th>Gender</th>
                                                <th>Hire Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listTop5Employee}" var="a">
                                                <tr>
                                                    <td>
                                                        <img width="28" height="28" class="rounded-circle" src="${a.image}" alt=""> 
                                                        <h2>${a.name}</h2>
                                                    </td>
                                                    <td>
                                                        <h2>${a.email}</h2>
                                                    </td>
                                                    <td>
                                                        <h2>${a.phoneNumber}</h2>
                                                    </td>
                                                    <td>
                                                        <h2>
                                                            <c:choose>
                                                                <c:when test="${a.gender eq 'true'}">Male</c:when>
                                                                <c:when test="${a.gender eq 'false'}">Female</c:when>
                                                            </c:choose>
                                                        </h2>
                                                    </td>
                                                    <td>
                                                        <h2>${a.hireDate}</h2>   
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
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
    <script src="assets/js/jquery.slimscroll.js"></script>
    <script src="assets/js/Chart.bundle.js"></script>
    <script src="assets/js/chart.js"></script>
    <script src="assets/js/app.js"></script>

</body>

</html>
