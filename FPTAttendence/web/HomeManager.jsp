

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Bootstrap CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link href="css/main.css" rel="stylesheet">
  <!-- FullCalendar CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.2/dist/fullcalendar.min.css" />
<link rel="stylesheet" href="css/styleManager.css">
</head>
  <title>Your Website</title>
</head>
<body>

    <header>
        <div class="container-fluid" > 
            <div class="row">
                <!-- <div class="col-auto"> -->
                <img src="y-nghia-logo-fpt-lan-3.jpg" alt="Company Logo">
                <!-- </div> -->
                <!-- <div class="col text-end"> -->
                <div class="user-info">
                    <p>Account</p>
                    <img src="avatar.jpg" alt="Avatar">
                    <a href="#">Logout</a>
                </div>
                <!-- </div> -->
            </div>
        </div>
    </header>
    <div class="container-fluid mt-4">
        <div class="row">
            <aside class="col-lg-2 col-md-3">
                <ul class="nav flex-column">
                    <li class="nav-item"><a id="attendance" class="nav-link" href="#">List Employees</a></li>
                    <li class="nav-item"><a id="profile" class="nav-link" href="#">Application</a></li>
                    <li class="nav-item"><a id="application"class="nav-link" href="#">Viết đơn</a></li>
                    <li class="nav-item"><a id="showapplication"class="nav-link" href="#">Xem các đơn đã gửi</a></li>
                    <li class="nav-item"><a id="Report"class="nav-link" href="#">Báo cáo</a></li>
                    <li class="nav-item"><a id="Nofitication"class="nav-link" href="#">Thông báo</a></li>
                </ul>
            </aside>

            <main class="col-lg-10 col-md-9" >  
                <section class="main-content"  >
                    <div class="row">
                        <div class="col-12">
                          <h1 class="display-4 text-center">Dashboard</h1>
                        </div>
                      </div>
                    
                      <div class="row mt-5">

                        <div class="col-md-3">
                          <div class="card border-0 shadow-sm">
                            <div class="card-body">
                              <h5 class="card-title">Departments</h5>
                              <p class="text-muted">List of departments...</p>
                            </div>
                          </div>  
                        </div>
                        <div class="col-md-3">
                            <div class="card border-0 shadow-sm"> 
                               <div class="card-body">
                                 <h5 class="card-title">Employees</h5>
                                 <p class="text-muted">Employee list...</p>
                               </div>
                             </div>
                           </div>
                      
                           <div class="col-md-3">
                            <div class="card border-0 shadow-sm"> 
                               <div class="card-body">
                                 <h5 class="card-title">Employees</h5>
                                 <p class="text-muted">Employee list...</p>
                               </div>
                             </div>
                           </div>
                      
                           <div class="col-md-3">
                            <div class="card border-0 shadow-sm"> 
                               <div class="card-body">
                                 <h5 class="card-title">Employees</h5>
                                 <p class="text-muted">Employee list...</p>
                               </div>
                             </div>
                           </div>
                          
                           <div class="col-md-4" style="margin-top: 20px">
                            <div class="card">
                              <div class="card-body">
                                <canvas id="myChart"></canvas>
                              </div>
                            </div>
                          </div>
                          <div class="col-md-4" style="margin-top: 20px">

                            <table class="table">
                              <thead>
                                <tr>
                                  <th>ID</th>
                                  <th>Name</th>
                                  <th>Status</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <td>1</td> 
                                  <td>John Doe</td>
                                  <td>Present</td>
                                </tr>
                                <tr>
                                  <td>2</td>
                                  <td>Jane Smith</td>  
                                  <td>Absent</td>
                                </tr>
                                <tr>
                                  <td>3</td>
                                  <td>Bob Williams</td>
                                  <td>Present</td>
                                </tr>
                              </tbody>
                            </table>
                          
                          </div>
                          <div class="col-md-4" style="margin-top: 20px">
                            <div class="calendar" id="calendar"></div>
                        </div>
                     
                          
            </main>
        </div>
    </div>

    <footer class="bg-light text-center p-3">
        <p>&copy; 2024 Your Company</p>
    </footer>
    <canvas id="myChart"></canvas>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="js/js2.js"></script>
</body>
</html>