<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Preclinic - Medical & Hospital - Bootstrap 4 Admin Template</title>
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
        }</style>
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
                            <h1 class="page-title" style="text-align: center">Notification</h1>
                        </div>
                        <div class="col-sm-4 col-6 text-left m-b-30">
                            <a href="ViewProject" class="btn btn-success btn-rounded">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left-circle-fill align-middle" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0m3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5z"/>
                                </svg>
                                <span class="align-middle">Back</span>
                            </a>
                        </div>
                        <% if (role == 3) { %>
                        <div class="col-sm-4 col-6 text-right m-b-30" style="margin-left: 30%">
                            <a href="#" class="btn btn-primary btn-rounded" data-toggle="modal" data-target="#add_event"><i class="fa fa-plus"></i> Add Task</a>
                        </div>
                        <% } %>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped custom-table mb-0 datatable">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>TaskName </th>
                                            <th>Employee Name </th>
                                            <th>Description </th>
                                            <th>DateEnd</th>
                                            <th>STATUS</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="o" items="${listTask}" varStatus="loop">
                                            <tr class="table_row">
                                                <td  class="column-1">${loop.index + 1}</td>    
                                                <td  class="column-1">${o.taskName}</td>
                                                <td  class="column-1">${o.EName}</td>
                                                <td  class="column-1">${o.description}</td>
                                                <td  class="column-2">${o.dateEnd}</td>

                                                <td  class="column-2 "> <c:choose>
                                                        <c:when test="${o.lol == 0}">
                                                            <span class="custom-badge status-red"> Failed</span>
                                                        </c:when>
                                                        <c:when test="${o.lol == 1}">
                                                            <span class="custom-badge status-orange"> Pending</span>
                                                            <c:if test="${em.employeeId eq o.employee_id}">
                                                                <a href="doneTask?TaskId=${o.taskId}" style="background-color: greenyellow"class="btn btn-primary btn-rounded" onclick="confirmAction(event)"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
                                                                    <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425z"/>
                                                                    </svg></a>
                                                                </c:if>

                                                        </c:when>
                                                        <c:when test="${o.lol == 2}">
                                                            <span class="custom-badge status-red"> Missing</span>

                                                        </c:when>
                                                        <c:when test="${o.lol == 3}">
                                                            <span class="custom-badge status-green"> Complete</span>
                                                        </c:when>
                                                    </c:choose></td>

                                        <form action="DeleteTask?TaskID=${o.taskId}" method="POST">

                                            <td class="column-2">
                                                <button class="rounded-square" style="background-color: red;" type="submit" value="Delete" name="btnAction" onclick="return confirmDeAction()">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                    <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
                                                    <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
                                                    </svg>
                                                </button>
                                                <a href="#" class="edit-project-btn" data-toggle="modal" data-target="#edit_project" onclick="fillEditForm('${o.taskId}', '${o.taskName}', '${o.description}', '${o.dateEnd}')">
                                                    <button type="submit" value="Edit" name="btnAction"style="background-color: yellow;"class="rounded-square">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pen-fill" viewBox="0 0 16 16">
                                                        <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001"/>
                                                        </svg>
                                                    </button>
                                                </a>

                                            </td>
                                        </form>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <% if (role == 3) { %>
                <c:set var="message" value="${mess}" /> 

                <c:choose>
                    <c:when test="${message eq true}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Successfull for create task for Employee</strong> </div>
                    </c:when>
                    <c:when test="${message eq false}">
                        <div class="alert alert-red alert-dismissible fade show" role="alert"><strong>Fail for create task for Employee</strong> </div>
                    </c:when>
                </c:choose>   
                <c:set var="message" value="${mess2}" /> 

                <c:choose>
                    <c:when test="${message eq true}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert"><strong>Successfull</strong> </div>
                    </c:when>
                    <c:when test="${message eq false}">
                        <div class="alert alert-red alert-dismissible fade show" role="alert"><strong>Fails</strong> </div>
                    </c:when>
                </c:choose>   
            </div>



            <div id="add_event" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content modal-md">
                        <div class="modal-header">
                            <h4 class="modal-title">Add Task for employees</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="createTask" method="Post" id="CreateTask">
                                <input class="form-control" type="text" name="MaId" value="<c:out value='${requestScope.MaId}' />"hidden>

                                <select name="employeeid">
                                    <c:forEach var="list1" items="${listEm}">
                                        <option value="${list1.employeeId}" >${list1.name}</option>
                                    </c:forEach>
                                </select>
                                <div class="form-group">
                                    <label>Name of Task <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" name="nameTask" required="">
                                </div>
                                <div class="form-group">
                                    <label>Description of Task <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" name="descriptionTask" required="" >                                                                                
                                </div>

                                <div class="form-group">
                                    <label>Date End <span class="text-danger">*</span></label>

                                    <input class="form-control " type=date name="dateEnd"required=>

                                </div>
                                <div class="m-t-20 text-center">
                                    <button class="btn btn-primary submit-btn" onclick="return confirmCreateTask();">Create Task</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <div id="edit_project" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content modal-md">
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Task</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="UpdateTask"id="edit_task_form" method="post">
                                <input type="hidden" id="project_id_input" name="TaskID">
                                <div class="form-group">
                                    <label>Name of Project <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" id="project_name_input" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label>Description <span class="text-danger">*</span></label>
                                    <input class="form-control" type="text" id="project_description_input" name="Description" required>                                                                               
                                </div>
                                <div class="form-group">
                                    <label>Date End <span class="text-danger">*</span></label>
                                    <input class="form-control" type="date" id="project_dateend_input" name="dateEnd" required>
                                </div>
                                <div class="m-t-20 text-center">
                                    <button type="submit"class="btn btn-primary submit-btn" onclick="return confirmEditTask();">Update Task</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>







        <div class="sidebar-overlay" data-reff=""></div>
        <script>
            function confirmAction(event) {
                event.preventDefault();

                if (confirm("Are you sure for done this Task ?")) {

                    window.location.href = event.target.href;
                } else {

                }
            }
        </script>
        <script>
            function confirmEditTask() {
                const form = document.getElementById("edit_task_form");
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

                if (confirm("Are you sure to Edit the Task?")) {
                    // N?u ng??i dùng nh?n OK
                    form.submit(); // G?i bi?u m?u
                } else {
                    return false; // H?y vi?c g?i bi?u m?u
                }
            }
            function confirmCreateTask() {
                const form = document.getElementById("CreateTask");
                const requiredFields = form.querySelectorAll("[required]");
                let isValid = true;

                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        isValid = false;
                    }
                });

                if (isValid) {
                    if (confirm("Are you sure to create the Task ?")) {
                        form.submit();
                    }
                } else {
                    alert("Please fill in all required fields.");
                }
            }
            function confirmDeAction() {
                if (confirm("Are you sure to create the Task ?")) {
                    // N?u ng??i dùng nh?n OK
                    document.querySelector("form").submit(); // G?i bi?u m?u
                    window.location.reload();
                } else {
                    // N?u ng??i dùng nh?n Cancel ho?c không ??ng ý
                    return false; // H?y vi?c g?i bi?u m?u
                }
            }
            function fillEditForm(TaskId, taskName, description, dateEnd) {

                document.getElementById("project_id_input").value = TaskId;
                document.getElementById("project_name_input").value = taskName;
                document.getElementById("project_description_input").value = description;
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


