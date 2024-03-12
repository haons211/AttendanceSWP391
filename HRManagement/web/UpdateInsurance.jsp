<%@ page import="models.AccountDTO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Update Insurance</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/employeecss.css">
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
            <% } else if (role == 3|| role == 1) { %>
            <jsp:include page="SideBarforManager.jsp" />
            <% } %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-sm-5 col-5">
                            <h4 class="page-title">Update Insurance</h4>
                        </div>




                        <div class="main">
                            <a href="insurance">
                                <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;">Back</button>
                            </a>                 
                            <form action="updateInsurance" method="post" >
                                <div class="main-text-table">
                                    <table>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Insurance ID
                                                </div>
                                            </td>
                                            <td >
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="insurance_id" value="${insurance.insuranceId}" style="width: 312px;" readonly="">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Employee ID
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="employee_id" value="${insurance.employeeId}" style="width: 312px;" readonly="">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Employee Name
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="name" value="${insurance.name}" style="width: 312px;"readonly>
                                                    </div>
                                                    <div style="color: red">
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Gender</td>
                                            <td>
                                                <div class="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="gender" 
                                                               value="${employee.gender ? 'Male' : 'Female'}" 
                                                               style="width: 312px;" readonly>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class="right-text-table">
                                                    Phone Number
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="phoneNumber" value="${insurance.phoneNumber}" style="width: 312px;" readonly="">
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Address</td>
                                            <td>
                                                <div class="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="address" value="${insurance.address}" style="width: 312px;" readonly="">
                                                    </div>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr >
                                            <td>
                                                <div class="right-text-table">
                                                    Insurance Company
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-input-table" style="margin-left: 40px">                                           
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="insurance_company" value="${insurance.insuranceCompany}" style="width: 312px;" >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorInsuranceCompanyWord}
                                                    </div>
                                                </div>
                                            </td>

                                            <td>Policy Number</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.policyNumber}"  name="policy_number"  >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorDouble}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="right-text-table">
                                                    Coverage Type        
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <select class="form-control" name="coverage_type" value="${insurance.coverageType}" style="width: 300px;">
                                                            <!-- Add options for coverage types -->

                                                            <option ${insurance.coverageType == "Health" ? 'selected' : ''}>Health</option>
                                                            <option ${insurance.coverageType == "Life" ? 'selected' : ''}>Life</option>
                                                            <option ${insurance.coverageType == "Accident" ? 'selected' : ''}>Accident</option>

                                                        </select>
                                                    </div>                                            
                                                </div>
                                            </td>
                                            <td>Policy Type</td>
                                            <td>
                                                <div class="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <select class="form-control" name="policy_type" value="${insurance.policyType}">
                                                            <option ${insurance.coverageType == "Health Insurance" ? 'selected' : ''}>Health Insurance</option>
                                                            <option ${insurance.coverageType == "Life Insurance" ? 'selected' : ''}>Life Insurance</option>
                                                            <option ${insurance.coverageType == "Accident Insurance" ? 'selected' : ''}>Accident Insurance</option>
                                                            <!-- Add more options as needed -->
                                                        </select>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Start Date
                                                </div>
                                            </td>
                                            <td>
                                                <div class = "right-input-table" style="margin-left: 40px" >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="start_date" value="${insurance.startDate}" >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorStartDate}
                                                    </div>
                                                </div>
                                            </td>
                                            <td>    
                                                End Date
                                            </td>
                                            <td>
                                                <div class ="left-input-table">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="end_date" value="${insurance.endDate}" style="width: 312px;" >
                                                    </div> 
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorEndDate}
                                                    </div>

                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Deductible 
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="deductible" value="${insurance.deductible}" style="width: 312px;">
                                                    </div>  
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorDeductibleDouble}
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Copay</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.coPay}" name="co_pay"  >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorCopayDouble}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Coverage Limit 
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="coverage_limit" value="${insurance.coverageLimit}" style="width: 312px;" >
                                                    </div> 
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorLimitDouble}
                                                    </div>
                                                </div>
                                            </td>

                                            <td>Premium Amount</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm"   name="premium_amount" value="${insurance.premiumAmount}" >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorAmountDouble}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Renewal Date 
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm"   name="renewal_date" value="${insurance.renewalDate}" >
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.messageErrorRenewalDate}
                                                    </div>
                                                </div>
                                            </td>

                                            <td>Coverage Details</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <textarea class="form-control" aria-label="Small"
                                                                  aria-describedby="inputGroup-sizing-sm" name="coverage_details" 
                                                                  style="width: 312px; height: 100px;">${insurance.coverageDetails}</textarea>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.remaindayError}
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td>
                                                <div class="right-text-table">
                                                    Beneficiary
                                                </div>
                                            </td>
                                            <td>
                                                <div class="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm"></span>
                                                        </div>
                                                        <select class="form-control" name="beneficiary" value="${insurance.beneficiary}" style="width: 312px;">
                                                            <!-- Add options for beneficiaries -->
                                                            <option ${insurance.beneficiary == null ? 'selected' : ''}>No beneficiary</option>
                                                            <option ${insurance.beneficiary == "Family" ? 'selected' : ''}>Family</option>
                                                            <option ${insurance.beneficiary == "Spouse" ? 'selected' : ''}>Spouse</option>
                                                            <option ${insurance.beneficiary == "Children" ? 'selected' : ''}>Children</option>
                                                            <!-- Add more options as needed -->
                                                        </select>
                                                    </div>                                               
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="add-to-system">
                                    <button type="submit" class="btn btn-success" style="margin: 10px 0 ;">Update Insurance</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sidebar-overlay" data-reff=""></div>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>

    </body>

</html>

