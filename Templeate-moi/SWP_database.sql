CREATE DATABASE IF NOT EXISTS SWP;
USE SWP;
-- Tạo bảng user_role
CREATE TABLE user_role (
  role_id INT AUTO_INCREMENT,
  name VARCHAR(20) NOT NULL,
  PRIMARY KEY (role_id)
);

-- Tạo bảng users
CREATE TABLE users (
  user_id INT AUTO_INCREMENT,
  username VARCHAR(20) NOT NULL,
  password VARCHAR(128) NOT NULL,
  role_id INT,
  PRIMARY KEY (user_id),
  FOREIGN KEY (role_id) REFERENCES user_role (role_id)
);

-- Tạo bảng employee
CREATE TABLE employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  phoneNumber VARCHAR(15),
  address VARCHAR(255),
  email VARCHAR(128) NOT NULL,
  gender BIT NOT NULL,
  image VARCHAR(128) NOT NULL,
  birth_date DATE NOT NULL,
  hire_date DATE NOT NULL,
  user_id INT,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Tạo bảng Config
CREATE TABLE Config (
  config_id INT PRIMARY KEY,
  intime_config TIME,
  outtime_config TIME,
  mockDay DATE,
  BeforeMockDay_gift INT,
  AfterMockDay_gift INT
);

-- Tạo bảng remainday
CREATE TABLE remainday (
  remainDay_id INT PRIMARY KEY,
  employee_id INT,
  yearOfWork INT,
  approvedLeaveDays INT,
  leaveDays INT,
  remainDay INT,
  config_id INT,
  FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
  FOREIGN KEY (config_id) REFERENCES Config (config_id)
);

-- Tạo trigger sau khi cập nhật Config
DELIMITER //
CREATE TRIGGER after_config_update
AFTER UPDATE ON Config
FOR EACH ROW
BEGIN
    UPDATE remainday r
    JOIN employee e ON r.employee_id = e.employee_id
    SET 
      r.approvedLeaveDays = CASE WHEN YEAR(CURDATE()) - YEAR(e.hire_date) < NEW.mockDay THEN NEW.BeforeMockDay_gift ELSE NEW.AfterMockDay_gift END,
      r.config_id = NEW.config_id,
      r.yearOfWork = YEAR(CURDATE()) - YEAR(e.hire_date)
    WHERE r.employee_id = e.employee_id;
END;
//
DELIMITER ;


-- Tạo trigger sau khi cập nhật hire_date trong bảng employee
DELIMITER //
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    UPDATE remainday r
    SET 
      r.yearOfWork = YEAR(CURDATE()) - YEAR(NEW.hire_date)
    WHERE r.employee_id = NEW.employee_id;
END;
//
DELIMITER ;

-- Tạo bảng department
CREATE TABLE department (
  department_id INT AUTO_INCREMENT NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (department_id)
);

-- Tạo bảng attendance
CREATE TABLE attendance (
  attendance_id INT AUTO_INCREMENT NOT NULL,
  employee_id INT NOT NULL,
  in_time TIME NOT NULL,
  out_time TIME NOT NULL,
  notes VARCHAR(120) NOT NULL,
  image VARCHAR(50) NOT NULL,
  status VARCHAR(11) NOT NULL,
  in_status VARCHAR(120) NOT NULL,
  out_status VARCHAR(120) NOT NULL,
  remainDay_id INT,
  department_id INT,
  PRIMARY KEY (attendance_id),
  FOREIGN KEY (employee_id) REFERENCES employee (employee_id),
  FOREIGN KEY (department_id) REFERENCES department (department_id),
  FOREIGN KEY (remainDay_id) REFERENCES remainday (remainDay_id)
);

-- Tạo trigger trước khi thêm vào để cập nhật in_status và out_status
DELIMITER //
CREATE TRIGGER update_status_before_insert
BEFORE INSERT ON attendance
FOR EACH ROW
BEGIN
    IF NEW.in_time > (SELECT intime_config FROM Config WHERE Config.config_id = 1) THEN
        SET NEW.in_status = 'muộn';
    ELSE
        SET NEW.in_status = 'oke';
    END IF;

    IF NEW.out_time > (SELECT outtime_config FROM Config WHERE Config.config_id = 1) THEN
        SET NEW.out_status = 'muộn';
    ELSE
        SET NEW.out_status = 'oke';
    END IF;
END;
//
DELIMITER ;

-- Tạo trigger trước khi cập nhật để cập nhật in_status và out_status
DELIMITER //
CREATE TRIGGER update_status_before_update
BEFORE UPDATE ON attendance
FOR EACH ROW
BEGIN
    IF NEW.in_time > (SELECT intime_config FROM Config WHERE Config.config_id = 1) THEN
        SET NEW.in_status = 'muộn';
    ELSE
        SET NEW.in_status = 'oke';
    END IF;

    IF NEW.out_time > (SELECT outtime_config FROM Config WHERE Config.config_id = 1) THEN
        SET NEW.out_status = 'muộn';
    ELSE
        SET NEW.out_status = 'oke';
    END IF;
END;
//
DELIMITER ;

-- Tạo bảng Notification
CREATE TABLE Notification (
  notification_id INT AUTO_INCREMENT NOT NULL,
  employee_id INT NOT NULL,
  description VARCHAR(255) NOT NULL,
  subject VARCHAR(255) NOT NULL,
  sent_date DATETIME NOT NULL,
  PRIMARY KEY (notification_id),
  FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

-- Tạo bảng type_application
CREATE TABLE type_application (
  type_id INT AUTO_INCREMENT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (type_id)
);

-- Tạo bảng application
CREATE TABLE application (
  application_id INT AUTO_INCREMENT NOT NULL,
  sender_id INT NOT NULL,
  type_id INT NOT NULL,
  receiver_id INT NOT NULL,
  file VARCHAR(255) NOT NULL,
  reason TEXT NOT NULL,
  status VARCHAR(50) NOT NULL,
  create_date DATETIME NOT NULL,
  complete_date DATETIME,
  PRIMARY KEY (application_id),
  FOREIGN KEY (type_id) REFERENCES type_application (type_id),
  FOREIGN KEY (sender_id) REFERENCES employee (employee_id),
  FOREIGN KEY (receiver_id) REFERENCES employee (employee_id)
);
-- Thêm dữ liệu cho bảng user_role
INSERT INTO user_role (name) VALUES
('admin'),
('user'),
('manager');

-- Thêm dữ liệu cho bảng users
INSERT INTO users (username, password, role_id) VALUES
('admin_user', 'admin_password', 1),
('normal_user', 'user_password', 2),
('manager_user', 'manager_password', 3);

-- Thêm dữ liệu cho bảng employee
INSERT INTO employee (name, phoneNumber, address, email, gender, image, birth_date, hire_date, user_id) VALUES
('Admin User', '123456789', 'Admin Address', 'admin@example.com', 1, 'admin.jpg', '1990-01-01', '2022-01-01', 1),
('Normal User', '987654321', 'User Address', 'user@example.com', 0, 'user.jpg', '1995-05-05', '2022-01-02', 2),
('Manager User', '555555555', 'Manager Address', 'manager@example.com', 1, 'manager.jpg', '1985-08-15', '2022-01-03', 3);

-- Thêm dữ liệu cho bảng Config
INSERT INTO Config (config_id, intime_config, outtime_config, mockDay, BeforeMockDay_gift, AfterMockDay_gift) VALUES
(1, '08:00:00', '17:00:00', '2022-01-15', 2, 5);

-- Thêm dữ liệu cho bảng remainday
INSERT INTO remainday (remainDay_id, employee_id, yearOfWork, approvedLeaveDays, leaveDays, remainDay, config_id) VALUES
(1, 1, 2, 5, 3, 2, 1),
(2, 2, 1, 2, 1, 1, 1),
(3, 3, 3, 8, 4, 4, 1);

-- Thêm dữ liệu cho bảng department
INSERT INTO department (name) VALUES
('Department A'),
('Department B'),
('Department C');

-- Thêm dữ liệu cho bảng attendance
INSERT INTO attendance (employee_id, in_time, out_time, notes, image, status, in_status, out_status, remainDay_id, department_id) VALUES
(1, '08:30:00', '17:30:00', 'Good day', 'attendance_image.jpg', 'Present', 'muộn', 'oke', 1, 1),
(2, '08:00:00', '16:45:00', 'On time', 'attendance_image.jpg', 'Present', 'oke', 'muộn', 2, 2),
(3, '09:15:00', '18:00:00', 'Late arrival', 'attendance_image.jpg', 'Present', 'muộn', 'muộn', 3, 3);

-- Thêm dữ liệu cho bảng Notification
INSERT INTO Notification (employee_id, description, subject, sent_date) VALUES
(1, 'You have a new message', 'New Message', '2022-01-20 10:30:00'),
(2, 'Approval for leave request', 'Leave Request', '2022-01-21 08:45:00'),
(3, 'Reminder: Upcoming meeting', 'Meeting Reminder', '2022-01-22 15:20:00');
-- Thêm dữ liệu cho bảng type_application
INSERT INTO type_application (name) VALUES
('Type A'),
('Type B'),
('Type C');
--- Sử lí M-M relationship
create table employeedepartment(
ed_id increment,
employee_id INT,
department_id INT,
primary key(employee_id,department_id),
foreign key(employee_id) references employee(employee_id),
foreign key(department_id) references department(department_id)
);