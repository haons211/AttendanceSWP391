<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Dash board employee</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <style>
            .containerr {
                display: flex;
                justify-content: space-between;
                background-color: #009efb;
                border-radius: 10px;
                padding: 40px;
                color: white;
                height: auto;
                width: 90%;
                margin: auto; /* C?n gi?a theo chi?u ngang */
                margin-bottom: 10px;
            }

            .rectangle {
                width: 90px;
                height: 120px;
                background-color: #fff;
                border-radius: 10px;
            }

            .user-info {
                text-align: center;
                flex-grow: 1;
            }

            .info {
                margin-bottom: 10px;
                font-size: xx-large;
            }

            .small-square {
                width: 120px;
                height: 120px;
                background-color: pink;
                border-radius: 10px;
                margin-left: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .current-date {
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 10px;
            }

            .input-field {
                margin-bottom: 10px;
            }

            .check-in-btn {
                width: 120px;
                background-color: #009efb;
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                transition: background-color 0.3s, color 0.3s;
                margin-top: 20px;
            }

            .check-in-btn:hover {
                background-color: #1976D2;
            }

            .check-in-btn:active {
                transform: translateY(2px);
            }

            .calendar {
                width: 100%;
                margin-top: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .calendar-header {
                background-color: #009efb;
                color: white;
                text-align: center;
                padding: 5px;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
            }

            .calendar-body {
                /*padding: 10px;*/
                display: flex;
                flex-wrap: wrap;
            }

            .calendar-day {
                width: calc(100% / 7);
                height: 30px;
                line-height: 30px;
                text-align: center;
                border: 1px solid #ccc;
            }

            .current-day {
                background-color: #009efb;
                color: white;
            }

            .weekdays {
                display: flex;
            }

            .weekday {
                width: calc(100% / 7);
                text-align: center;
                font-weight: normal;
            }
            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
            }

            textarea {
                width: 100%;
                box-sizing: border-box;
            }
        </style>
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
            <% } else if (role == 3) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-4">
                            <h4 class="page-title">Attendance Form</h4>
                        </div>
                        <div id="currentDate" class="current-date"></div>
                    </div>
                    <div class="row">
                        <div class="containerr">
                            <div class="rectangle">
                                <img src="assets/img/user.jpg" width="100%" height="100%" alt="">
                            </div>
                            <div class="user-info">
                                <div class="info">Hello,${em.name}!</div>
                                <div class="info">Have a good day.</div>
                            </div>
                            <div class="small-square">Remaind day<br>${re}</div>
                            <div class="small-square" id="totalTime">Total time</div>
                        </div>
                        <div class="col-md-8">
                            <form action="HomeEmployees" method="post">
                                <div class="form-group">
                                    <label for="message">Message:</label>
                                    <textarea id="message" name="message" rows="4" placeholder="Enter your message"></textarea>
                                </div>
                                <button class="check-in-btn" type="submit">Check In</button>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <div class="calendar" id="calendar"></div>
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
                var currentDate = new Date();
                var options = {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                };
                document.getElementById('currentDate').textContent = currentDate.toLocaleDateString('en-US', options);
            </script>
            <script>
                var currentDate = new Date();
                var currentYear = currentDate.getFullYear();
                var currentMonth = currentDate.getMonth();
                var currentDay = currentDate.getDate();
                var calendarElement = document.getElementById("calendar");
                var calendarHTML = "";
                var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                var dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                calendarHTML += '<div class="calendar-header">' + monthNames[currentMonth] + ' ' + currentYear + '</div>';
                calendarHTML += '<div class="weekdays">';
                for (var i = 0; i < dayNames.length; i++) {
                    calendarHTML += '<div class="weekday">' + dayNames[i] + '</div>';
                }
                calendarHTML += '</div>';
                calendarHTML += '<div class="calendar-body">';
                var firstDayOfMonth = new Date(currentYear, currentMonth, 1).getDay();
                var daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
                var counter = 0;
                for (var i = 0; i < firstDayOfMonth; i++) {
                    calendarHTML += '<div class="calendar-day"></div>';
                    counter++;
                }
                for (var day = 1; day <= daysInMonth; day++) {
                    var className = (day === currentDay) ? 'calendar-day current-day' : 'calendar-day';
                    calendarHTML += '<div class="' + className + '">' + day + '</div>';
                    counter++;
                }
                for (var i = counter; i % 7 !== 0; i++) {
                    calendarHTML += '<div class="calendar-day"></div>';
                }
                calendarHTML += '</div>';
                calendarElement.innerHTML = calendarHTML;
            </script>
</html>