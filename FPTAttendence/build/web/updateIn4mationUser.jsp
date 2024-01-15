<%-- 
    Document   : updateIn4mationUser
    Created on : Jan 14, 2024, 2:13:04 AM
    Author     : NCM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style> body {
  font-family: Arial, sans-serif;
  background-color: #f2f2f2;
  padding: 20px;
}

h1 {
  text-align: center;  
  color: #0077b6;
}

form {
  background-color: #fff;
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

label {
  display: block;
  font-weight: bold;
  margin-bottom: 10px;
}

input, select {
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
  width: 100%;
  margin-bottom: 20px;  
}

input[type="submit"] {
  background-color: #0077b6;
  color: #fff;
  border: none;
  cursor: pointer;
}

input[type="submit"]:hover {
  background-color: #00a2f9;
} </style>
    </head>
    <body>
        <h1>Update Student Information</h1>

        <form action="HomeEmployees" method="post">
            <input type="hidden" id="empId" name="empId" value="${param.idse}" readonly>

            <label for="empName">Name:</label>
            <input type="text" id="empName" name="empName" required><br><br>


            <label for="empNumber">PhoneNumber:</label>
            <input type="text" id="empNumber" name="empNumber" required><br><br>

            <label for="empAddress">Address:</label>
            <input type="text" id="empAddress" name="empAddress" required><br><br> 
             <label for="empEmail">Mail:</label>
            <input type="text" id="empEmail" name="empEmail" required><br><br> 
            <label for="empGender">Gender:</label> 
            <select id="empGender" name="empGender" required>
    <option value="" disabled>Select gender</option>
    <option value="1">Male</option>
    <option value="0">Female</option>
</select><br><br>

            <label for="empBirthdate">Birthdate:</label>
            <input type="date" id="empBirthdate" name="empBirthdate" required><br><br>

            <input type="submit" value="Update" name="btAction">
        </form>
    </body>
</html>
