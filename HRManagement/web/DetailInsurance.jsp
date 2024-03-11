<%@ page import="models.AccountDTO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Detail Insurance</title>
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
                            <h4 class="page-title">Detail Insurance</h4>
                        </div>
                        <div class="col-sm-7 col-7 text-right m-b-30">
                            <a href="addInsurance" class="btn btn-primary btn-rounded"><i class="fa fa-plus"></i> Add Insurance</a>
                        </div>
                        <div class="col-sm-12 col-12 text-right m-b-30">
                            <a href="updateInsurance?Iid=${o.insuranceId}" class="btn btn-primary btn-rounded"><i class="fa fa-pencil"></i> Edit Insurance</a>
                        </div>
                        
                  

                        <div class="main">
                            <a href="insurance">
                                <button type="button" class="btn btn-secondary" style="margin: 10px 0 ;">Back</button>
                            </a>                 
                            <form action="detailInsurance" method="post" >
                                <div class="main-text-table">
                                    <table>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Insurance ID
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
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
                                                               aria-describedby="inputGroup-sizing-sm" name="name" value="${insurance.name}" style="width: 312px;" readonly="">
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
                                                               value="${insurance.gender ? 'Male' : 'Female'}" 
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
                                                               aria-describedby="inputGroup-sizing-sm" name="insurance_company" value="${insurance.insuranceCompany}" style="width: 312px;" readonly>
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
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.policyNumber}"  name="policy_number"  readonly="">
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
                                                <div class = "right-input-table" style="margin-left: 40px" >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="coverage_type" value="${insurance.coverageType}" style="width: 300px;" readonly="">
                                                    </div>                                            
                                                </div>
                                            </td>
                                            <td>Policy Type</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.policyType}"  name="policy_type"  readonly="">
                                                    </div>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    End Date
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="end_date" value="${insurance.endDate}" style="width: 312px;" readonly="">
                                                    </div>         
                                                </div>
                                            </td>
                                            <td>Start Date</td>
                                            <td>
                                                <div class = "left-input-table"  >
                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="date" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.startDate}"  name="start_date"  readonly="">
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
                                                               aria-describedby="inputGroup-sizing-sm" name="deductible" value="${insurance.deductible}$" style="width: 312px;" readonly>
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
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.coPay}$"  name="co_pay"  readonly="">
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
                                                               aria-describedby="inputGroup-sizing-sm" name="coverage_limit" value="${insurance.coverageLimit}$" style="width: 312px;" readonly>
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
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.premiumAmount}$"  name="premium_amount"  readonly="">
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.remaindayError}
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
                                                               aria-describedby="inputGroup-sizing-sm" value="${insurance.renewalDate}"  name="renewal_date"  readonly="">
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
                                                                  style="width: 312px; height: 100px;" readonly>${insurance.coverageDetails}</textarea>
                                                    </div>
                                                    <div style="color: red">
                                                        ${requestScope.remaindayError}
                                                    </div>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr >
                                            <td>
                                                <div class = "right-text-table">
                                                    Beneficiary 
                                                </div>
                                            </td>
                                            <td>
                                                <div class ="right-input-table" style="margin-left: 40px">


                                                    <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                            <span class="input-group-text" id="inputGroup-sizing-sm" ></span>
                                                        </div>
                                                        <input type="text" class="form-control" aria-label="Small"
                                                               aria-describedby="inputGroup-sizing-sm" name="beneficiary" 
                                                               value="${insurance.beneficiary != null ? insurance.beneficiary : 'No beneficiary'}" 
                                                               style="width: 312px;" readonly>
                                                        ${insurance.beneficiary != null ? '<button type="button" class="btn btn-primary" onclick="viewBeneficiary()">View Beneficiary</button>' : ''}
                                                    </div>                                               
                                                </div>
                                            </td>                
                                        </tr>
                                    </table>
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

