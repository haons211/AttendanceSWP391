<%-- 
    Document   : ViewSalaryEmployee
    Created on : Mar 11, 2024, 1:09:03 PM
    Author     : Dan
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.AccountDTO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title></title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">

    </head>

    <body>
        <div class="main-wrapper">
            <%@include file="SideBarSetting.jsp" %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-4">
                            <h4 class="page-title">Payslip</h4>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card-box">
                                <h4 class="payslip-title">Payslip for the month of March 2024</h4>
                                <div class="row">
                                    <div class="col-sm-6 m-b-20">
                                        <img src="assets/img/logo-dark.png" class="inv-logo" alt="">
                                        <ul class="list-unstyled mb-0">
                                            <li>${company.companyName} Company</li>

                                            <li>Address: ${company.address}</li>
                                        </ul>
                                    </div>
                                    <div class="col-sm-6 m-b-20">
                                        <div class="invoice-details">
                                            <h3 class="text-uppercase">Payslip ${employeeSalary.salaryId}</h3>
                                            <ul class="list-unstyled">
                                                <li>Salary Month: <span>March, 2024</span></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 m-b-20">
                                        <ul class="list-unstyled">
                                            <li>
                                                <h5 class="mb-0"><strong>${employeeSalary.ename}</strong></h5></li>

                                            <li>Employee ID: ${employeeSalary.employeeId}</li>
                                            <li>Joining Date: ${employeeSalary.hireDate}</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div>
                                            <h4 class="m-b-10"><strong>Earnings</strong></h4>
                                            <table class="table table-bordered">
                                                <tbody>
                                                   
                                                    <tr>
                                                        <td><strong>Allowance</strong> <span class="float-right">$${employeeSalary.allowance}</span></td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Bonus</strong> <span class="float-right">$${employeeSalary.bonus}</span></td>
                                                      <tr>
                                                        <td><strong>Basic Salary</strong> <span class="float-right"><strong>$${employeeSalary.basicSalary }</strong></span></td>
                                                    </tr>
                                                   
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div>
                                            <h4 class="m-b-10"><strong>Tax</strong></h4>
                                            <table class="table table-bordered">
                                                <tbody>
                                                    <tr>
                                                        <td><strong>Personal Income Tax</strong> <span class="float-right">$${employeeSalary.tax}</span></td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <td><strong>Insurance</strong> <span class="float-right">$0</span></td>
                                                    </tr>

                                                    <tr>
                                                        <td><strong>Total Deductions</strong> <span class="float-right"><strong>$${employeeSalary.tax }</strong></span></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <p id="netSalaryText"><strong>Net Salary: $${employeeSalary.basicSalary + employeeSalary.bonus + employeeSalary.allowance - employeeSalary.tax }</strong></p>
                                    </div>

                                    <div class="col-sm-12">
                                        <p id="netSalaryInWords"></p>
                                    </div>
                                </div>
                            </div>
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
        <script src="assets/js/app.js"></script>

        <script>
            function convertToEnglishWords(number) {
                var ones = ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
                var tens = ['', 'ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];
                var teens = ['', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'];
                var thousands = ['', 'thousand', 'million', 'billion', 'trillion'];

                function capitalizeFirstLetter(word) {
                    return word.charAt(0).toUpperCase() + word.slice(1);
                }

                ones = ones.map(capitalizeFirstLetter);
                tens = tens.map(capitalizeFirstLetter);
                teens = teens.map(capitalizeFirstLetter);
                thousands = thousands.map(capitalizeFirstLetter);

                function convertGroup(number) {
                    var result = '';

                    var hundredsDigit = Math.floor(number / 100);
                    if (hundredsDigit !== 0) {
                        result += ones[hundredsDigit] + ' hundred ';
                    }

                    var tensDigit = Math.floor((number % 100) / 10);
                    var onesDigit = number % 10;

                    if (tensDigit === 1 && onesDigit !== 0) {
                        result += teens[onesDigit];
                    } else {
                        result += tens[tensDigit] + ' ' + ones[onesDigit];
                    }

                    return result.trim();
                }

                var parts = [];
                while (number > 0) {
                    parts.push(number % 1000);
                    number = Math.floor(number / 1000);
                }

                var words = '';
                for (var i = 0; i < parts.length; i++) {
                    if (parts[i] !== 0) {
                        words = convertGroup(parts[i]) + ' ' + thousands[i] + ' ' + words;
                    }
                }

                return words.trim();
            }

            var netSalary = Math.round(${employeeSalary.basicSalary + employeeSalary.bonus + employeeSalary.allowance - employeeSalary.tax }); // Round the net salary
            var netSalaryInWords = convertToEnglishWords(netSalary);

            document.getElementById("netSalaryInWords").innerText = "Net Salary : " + netSalaryInWords;
        </script>
    </body>

</html>
