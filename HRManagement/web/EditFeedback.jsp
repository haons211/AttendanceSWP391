<%-- 
    Document   : EditFeedback
    Created on : Mar 12, 2024, 7:15:02 PM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Salary</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">

    </head>

    <body>


        <div class="main-wrapper">
            <%@include file="SideBarforEm.jsp" %>
            <div class="page-wrapper">
                <div class="content">

                    <div class="container mt-5">
                        <h2 class="mb-4">Edit Feedback</h2>
                        <c:set var="id" value="${requestScope.id}" />
                        <form action="EditFeedback" method="post" >
                            <input type="hidden" name="id" value="${id}"/>
                            <div class="d-flex justify-content-lg-around">
                                <h3 >Title</h3>
                                <h3 >Add Other Title</h3>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <select class="form-control" name="titleSelect" id="titleSelect">
                                        <c:forEach items="${listTitle}" var="listTitle">
                                            <option value="${listTitle.title}" >${listTitle.title}</option>
                                        </c:forEach>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <div class="form-group col-md-6" id="otherTitleGroup" style="display:none;">
                                    <input type="text" class="form-control" placeholder="Other Title ...." name="otherTitle" required>
                                </div>
                           </div>
                            <div class="form-group">
                                <label for="content">Content</label>  
                                <textarea class="form-control" id="content" name="content" rows="5" style="resize: none;"  required>${feedback.content}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Send</button>
                        </form>

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
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const titleSelect = document.getElementById("titleSelect");
                const otherTitleGroup = document.getElementById("otherTitleGroup");
                const otherTitleInput = document.querySelector("#otherTitleGroup input[name='otherTitle']");

                titleSelect.addEventListener("change", function () {
                    if (titleSelect.value === "other") {
                        otherTitleGroup.style.display = "block";
                        otherTitleInput.required = true;
                    } else {
                        otherTitleGroup.style.display = "none";
                        otherTitleInput.required = false;
                    }
                });
            });


        </script>


    </body>

</html>


