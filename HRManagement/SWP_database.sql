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
  dep_code VARCHAR(50) NOT NULL,
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
('adminuser','5291a0858dfafff116e37dea26d5bfaf',1),
('normaluser','5291a0858dfafff116e37dea26d5bfaf',2),
('manageruser','5291a0858dfafff116e37dea26d5bfaf',3);

-- Thêm dữ liệu cho bảng employee
-- Tạo dữ liệu giả cho bảng employee
INSERT INTO employee (name, phoneNumber, address, email, gender, image, birth_date, hire_date, user_id) VALUES
('Nguyễn Văn A', '0987654321', 'Số 10, Đường Nguyễn Chí Thanh, Hà Nội', 'van.a@example.com', 1, 'van_a.jpg', '1990-05-15', '2022-01-01', 1),
('Trần Thị B', '0912345678', 'Số 20, Đường Lê Lợi, Hồ Chí Minh', 'thi.b@example.com', 0, 'thi_b.jpg', '1993-08-25', '2022-01-02', 2),
('Lê Văn C', '0905123456', 'Số 30, Đường Trần Hưng Đạo, Đà Nẵng', 'van.c@example.com', 1, 'van_c.jpg', '1988-02-10', '2022-01-03', 3),
('Hoàng Thị D', '0978123456', 'Số 40, Đường Nguyễn Huệ, Cần Thơ', 'thi.d@example.com', 0, 'thi_d.jpg', '1997-11-30', '2022-01-04', 1),
('Phạm Văn E', '0987123456', 'Số 50, Đường Trần Phú, Hải Phòng', 'van.e@example.com', 1, 'van_e.jpg', '1991-04-20', '2022-01-05', 2);

-- Thêm dữ liệu cho bảng Config
INSERT INTO Config (config_id, intime_config, outtime_config, mockDay, BeforeMockDay_gift, AfterMockDay_gift) VALUES
(1, '08:00:00', '17:00:00', '2022-01-15', 2, 5);

-- Thêm dữ liệu cho bảng remainday
INSERT INTO remainday (remainDay_id, employee_id, yearOfWork, approvedLeaveDays, leaveDays, remainDay, config_id) VALUES
(1, 1, 2, 5, 3, 2, 1),
(2, 2, 1, 2, 1, 1, 1),
(3, 3, 3, 8, 4, 4, 1);

-- Thêm dữ liệu cho bảng department
INSERT INTO department (name, dep_code) VALUES
('Software Engineering', 'SE'),
('Digital Marketing', 'DM'),
('Bussiness Analyst', 'BA');

-- Thêm dữ liệu cho bảng attendance
-- Thêm dữ liệu giả cho bảng attendance
INSERT INTO attendance (employee_id, in_time, out_time, notes, image, status, in_status, out_status, remainDay_id, department_id) VALUES
(1, '08:30:00', '17:30:00', 'Ngày làm việc tốt', 'anh_chamcong.jpg', 'Present', 'đúng giờ', 'đúng giờ', 1, 1),
(2, '08:00:00', '16:45:00', 'Đi đúng giờ', 'anh_chamcong.jpg', 'Present', 'đúng giờ', 'trễ giờ', 2, 2),
(3, '09:15:00', '18:00:00', 'Đi muộn', 'anh_chamcong.jpg', 'Present', 'trễ giờ', 'trễ giờ', 3, 3);

-- Thêm dữ liệu cho bảng Notification
INSERT INTO Notification (employee_id, description, subject, sent_date) VALUES
(1, 'You have a new message', 'New Message', '2022-01-20 10:30:00'),
(2, 'Approval for leave request', 'Leave Request', '2022-01-21 08:45:00'),
(3, 'Reminder: Upcoming meeting', 'Meeting Reminder', '2022-01-22 15:20:00');

-- Thêm dữ liệu cho bảng type_application
INSERT INTO type_application (name) VALUES
('Nghỉ phép'),
('Đi muộn'),
('Về sớm'),
('Công tác'),
('Nghỉ bệnh'),
('Nghỉ phục vụ dân sự');

-- Sử lí M-M relationship
CREATE TABLE employeedepartment (
  employee_id INT,
  department_id INT,
  PRIMARY KEY (employee_id, department_id),
  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  FOREIGN KEY (department_id) REFERENCES department(department_id)
);
