<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Project in Department</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <!--[if lt IE 9]>
                    <script src="assets/js/html5shiv.min.js"></script>
                    <script src="assets/js/respond.min.js"></script>
            <![endif]-->
    </head>

    <style>.ellipsis {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
            display: inline-block;

        }
        .rounded-square {
            background-color: red; /* Màu n?n c?a nút */
            border: none; /* Lo?i b? ???ng vi?n */
            border-radius: 10px; /* Thi?t l?p góc cong cho nút */
            width: 40px; /* ?? r?ng c?a nút */
            height: 40px; /* Chi?u cao c?a nút */
            padding: 0; /* Lo?i b? padding */
            cursor: pointer; /* Bi?u t??ng con tr? khi di chu?t qua */
        }

        /* Thay ??i màu n?n khi di chu?t qua */
        .rounded-square:hover {
            background-color: darkred;
        }

        /* Thay ??i màu n?n khi nh?n nút */
        .rounded-square:active {
            background-color: firebrick;
        }
    </style>
    <body>
        <%
                     AccountDTO acc = (AccountDTO) session.getAttribute("account");
                     int role=     acc.getRole();
        %>

        <c:set var="em" value="${emp}" />
        <div class="main-wrapper">
            <% if (role == 2) { %>
            <jsp:include page="SideBarforEm.jsp" />
            <% } else if (role == 3) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">

                <div class="content">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="page-title" style="text-align: center">Project</h1>
                        </div>
                        <%  if (role == 3) { %>
                        <div class="col-sm-4 col-8 text-right m-b-30" style="margin-left: 65%;">
                            <a href="#" class="btn btn-primary btn-rounded" data-toggle="modal" data-target="#add_event"><i class="fa fa-plus"></i> Add Project</a>
                        </div> <% } %>
                    </div>
                    <div class="main-option">
                        <div class="main-option-search">
                            <nav class="navbar navbar-light bg-light justify-content-between">

                                <div class="form-group mr-sm-2 flex-grow-1">
                                    <label for="fromDate">Search:</label>
                                    <input class="form-control w-100" name="search" type="text" placeholder="Search" aria-label="Search" style="height: 30px;">
                                </div>
                                <div class="form-group mr-sm-2" style="margin-top: 25px">
                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;"name="btAction" value="Search">Search</button>
                                </div>
                                <div class="form-group mr-sm-2">
                                    <label for="fromDate">From:</label>
                                    <input type="date" name="dateFrom" id="fromDate" class="form-control" style="height: 30px;  ">
                                </div>
                                <div class="form-group mr-sm-2">
                                    <label for="toDate">To:</label>
                                    <input type="date" name="dateEnd" id="toDate" class="form-control" style="height: 30px;">
                                </div>
                                <div class="form-group mr-sm-2"style="margin-top: 25px">
                                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="height: 40px;"name="btAction"value="Find">Find</button>
                                </div>

                            </nav>


                        </div>
                    </div>

                    </form>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table mb-0 datatable">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>ProjectName </th>
                                            <th>DateFrom</th>
                                            <th>DateEnd</th>
                                            <th>STATUS</th>
                                                <%  if (role == 3) { %>
                                            <th>Action</th>
                                                <% } %>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach var="o" items="${lpformanager}" varStatus="loop">

                                            <tr class="table_row">

                                                <td  class="column-1">${loop.index + 1}</td>    
                                                <td  class="column-1"><a href="createTask?ProjectID=${o.projectId}">${o.projectName}</a></td>
                                                <td  class="column-2">${o.dateStart}</td>
                                                <td  class="column-2">${o.dateEnd}</td>
                                                <td  class="column-2 "> <c:choose>
                                                        <c:when test="${o.lol == 0}">
                                                            <span class="custom-badge status-red"> Failed</span>
                                                        </c:when>
                                                        <c:when test="${o.lol == 1}">
                                                            <span class="custom-badge status-orange"> Pending</span>
                                                        </c:when>

                                                        <c:when test="${o.lol == 3}">
                                                            <span class="custom-badge status-green"> Complete</span>
                                                        </c:when>
                                                    </c:choose></td>
                                                    <%  if (role == 3) { %>
                                        <form action="ManagerProject?ProjectID=${o.projectId}" method="POST"  id="formToDelete">
                                            <td class="column-2">
                                                
                                                <button class="rounded-square" style="background-color: red;" type="submit" value="Delete" name="btnAction" onclick="return confirmAction()">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                    <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                                    <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                                    </svg>
                                                </button>
                                                <a href="#" class="edit-project-btn" data-toggle="modal" data-target="#edit_project" onclick="fillEditForm('${o.projectId}', '${o.projectName}', '${o.description}', '${o.dateStart}', '${o.dateEnd}')">
                                                    <button type="submit" value="Edit" name="btnAction"style="background-color: yellow;"class="rounded-square">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pen-fill" viewBox="0 0 16 16">
                                                        <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001"/>
                                                        </svg>
                                                    </button>
                                                </a>
                                               

                                            </td>

                                           
                                        </form>
 <% } %> 

                                        </tr>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <c:set var="message" value="${mess1}" /> 

                <c:choose>

                    <c:when test="${message eq true}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Successfull for create Project </strong> </div>
                    </c:when>
                    <c:when test="${message eq false}">
                        <div class="alert alert-red alert-dismissible fade show" role="alert"><strong>Fail for create Project</strong> </div>
                    </c:when>
                </c:choose>  
                <c:set var="message" value="${mess}" /> 

                <c:choose>
                    <c:when test="${message eq true}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Successfull for Delete Project</strong> </div>
                    </c:when>
                    <c:when test="${message eq false}">
                        <div class="alert alert-red alert-dismissible fade show" role="alert"><strong>Fail for for Delete Project</strong> </div>
                    </c:when>

                </c:choose>    
                <c:set var="message" value="${mess2}" /> 
                <c:choose>
                    <c:when test="${message eq true}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Successfull for Update Project</strong> </div>
                    </c:when>
                    <c:when test="${message eq false}">
                        <div class="alert alert-red alert-dismissible fade show" role="alert"><strong>Fail for for Update Project</strong> </div>
                    </c:when>

                </c:choose>    
            </div>



            <div id="add_event" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content modal-md">
                        <div class="modal-header">
                            <h4 class="modal-title">Add Project for employees</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="CreateProject" method="Post">
                                <input type="type" name="eid" value="${em.employeeId}" hidden>
                                <div class="form-group">
                                    <label>Name of Project <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label>Description <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" name="Description" required >                                                                               
                                </div>
                                <div class="form-group">
                                    <label>Date Start <span class="text-danger">*</span></label>

                                    <input class="form-control" type="date"name="dateStart"required>

                                </div>
                                <div class="form-group">
                                    <label>Date End <span class="text-danger">*</span></label>

                                    <input class="form-control " type=date name="dateEnd"required>

                                </div>
                                <div class="m-t-20 text-center">
                                    <button class="btn btn-primary submit-btn" onclick="return confirmCreateProject();">Create Project</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>



            <div id="edit_project" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content modal-md">
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Project</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="EditProject"id="edit_project_form" method="post">
                                <input type="hidden" id="project_id_input" name="projectID">
                                <div class="form-group">
                                    <label>Name of Project <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" id="project_name_input" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label>Description <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" id="project_description_input" name="Description" required>                                                                               
                                </div>
                                <div class="form-group">
                                    <label>Date Start <span class="text-danger">*</span></label>
                                    <input class="form-control" type="date" id="project_datestart_input" name="dateStart" required>
                                </div>
                                <div class="form-group">
                                    <label>Date End <span class="text-danger">*</span></label>
                                    <input class="form-control" type="date" id="project_dateend_input" name="dateEnd" required>
                                </div>
                                <div class="m-t-20 text-center">
                                    <button type="submit"class="btn btn-primary submit-btn" onclick="return confirmUpdateProject();">Update Project</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>







        <div class="sidebar-overlay" data-reff=""></div>
        <script>
            function confirmCreateProject() {
                var startDate = new Date(document.querySelector('#add_event input[name="dateStart"]').value);
                var endDate = new Date(document.querySelector('#add_event input[name="dateEnd"]').value);

                if (endDate <= startDate) {
                    alert("The end date must be after the previous date");
                    return false; // Ng?n ch?n vi?c g?i bi?u m?u
                }

                const form = document.querySelector('#add_event form');
                const requiredFields = form.querySelectorAll('[required]');
                let isValid = true;

                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                    }
                });

                if (!isValid) {
                    alert("Please fill in all required fields.");
                    return false;
                }

                if (confirm("Are you sure to create the Project?")) {
                    // N?u ng??i dùng nh?n OK
                    form.submit(); // G?i bi?u m?u
                } else {
                    return false; // H?y vi?c g?i bi?u m?u
                }
            }
            function confirmUpdateProject() {
               const form = document.getElementById("edit_project_form");

                const requiredFields = form.querySelectorAll('[required]');
                let isValid = true;

                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                    }
                });

                if (!isValid) {
                    alert("Please fill in all required fields.");
                    return false;
                }

                if (confirm("Are you sure to Update the project?")) {
                    // N?u ng??i dùng nh?n OK
                    form.submit(); // G?i bi?u m?u
                } else {
                    return false; // H?y vi?c g?i bi?u m?u
                }
            }
            function confirmAction() {
              
                if (confirm("Are you sure to delete this Project ?")) {
                 
                    document.getElementById("formToDelete").submit();
                } else {
                    // N?u ng??i dùng nh?n Cancel, không làm gì c?
                    return false;
                }
            }
            function fillEditForm(projectId, projectName, description, dateStart, dateEnd) {

                document.getElementById("project_id_input").value = projectId;
                document.getElementById("project_name_input").value = projectName;
                document.getElementById("project_description_input").value = description;
                document.getElementById("project_datestart_input").value = dateStart;
                document.getElementById("project_dateend_input").value = dateEnd;
            }


        </script>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/moment.min.js"></script>
        <script src="assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>

