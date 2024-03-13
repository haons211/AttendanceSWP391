<%-- 
    Document   : Settting.jsp
    Created on : Feb 26, 2024, 10:38:38 PM
    Author     : Dan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <title>Setting</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/select2.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">

    </head>
    <body>
        <div class="main-wrapper">
            <%@include file="SideBarSetting.jsp" %>
            <div class="page-wrapper">
                <div class="content">
                    <div class="row">
                        <div class="col-lg-8 offset-lg-2">

                            <form action="UpdateCompany" method="post" >
                                <h3 class="page-title">Company Settings</h3>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Company Name </label>
                                            <c:if test="${companyName!=null}">
                                                <input class="form-control" type="text" required="" name="companyName" value="${companyName}">
                                            </c:if>
                                            <c:if test="${companyName==null}">
                                                <input class="form-control" type="text" required="" name="companyName" value="${company.companyName}">
                                            </c:if>

                                            <c:if test="${messageErrorCname!=null}">
                                                <div class="text-center alert-danger">
                                                    <label > ${messageErrorCname}</label>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Contact Person</label>
                                            <c:if test="${employeeName!=null}">
                                                <input class="form-control" type="text" required="" name="employeeName" value="${employeeName}">
                                            </c:if>
                                            <c:if test="${employeeName==null}">
                                                <input class="form-control" type="text" required="" name="employeeName" value="${employee1.name}">
                                            </c:if>

                                            <c:if test="${messageErrorEname!=null}">
                                                <div class="text-center alert-danger">
                                                    <label > ${messageErrorEname}</label>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label>Address</label>

                                            <c:if test="${address!=null}">
                                                <input class="form-control" type="text" required="" name="address" value="${address}">
                                            </c:if>
                                            <c:if test="${address==null}">
                                                <input class="form-control" type="text" required="" name="address" value="${company.address}">
                                            </c:if>

                                            <c:if test="${messageErrorAddress!=null}">
                                                <div class="text-center alert-danger">
                                                    <label > ${messageErrorAddress}</label>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input class="form-control" value="${company.email}" required="" name="email" type="email">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Phone Number</label>
                                            <input class="form-control" value="${company.phoneNumber}" required="" name="phoneNumber" type="text">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Fax</label>
                                            <input class="form-control" value="${company.fax}" required="" name="fax" type="text">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Department Name</label>
                                            <input class="form-control" value="${department.name}" required="" name="departmentName" type="text">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label>Website Url</label>
                                            <input class="form-control" value="${company.website}" required="" name="website" type="text">
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${account.getRole() != 2}">

                                    <div class="row">
                                        <div class="col-sm-12 text-center m-t-20">
                                            <button type="submit" class="btn btn-success submit-btn">Save</button>
                                        </div>
                                    </div>
                                </c:if>

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
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>