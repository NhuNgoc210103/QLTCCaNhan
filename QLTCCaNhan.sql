--tao CSDL
create database QLTCCaNhan
go

--kich hoat csdl
use QLTCCaNhan
go

-- tao bang
CREATE TABLE TaiKhoan (
    id INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(255),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    SoDienThoai NVARCHAR(20),
    TenDangNhap NVARCHAR(50),
    MatKhau NVARCHAR(50)
);
go


CREATE TABLE QLThu
(
   MaThu NVARCHAR(50) NOT NULL PRIMARY KEY,
   TenLoaiThu NVARCHAR(50) NOT NULL,
   NgayThu DATE NOT NULL,
   SoTien DECIMAL(10,3) NOT NULL,
   GhiChu NVARCHAR(50),
   id int,
   foreign key (id) references TaiKhoan(id)
);
go

CREATE TABLE QLChiNguoiThan
(
   MaChi NVARCHAR(50) NOT NULL PRIMARY KEY,
   TenLoaiChi NVARCHAR(50) NOT NULL,
   NgayChi DATE NOT NULL,
   SoTien DECIMAL(10,3) NOT NULL,
   GhiChu NVARCHAR(50),
   id int,
   foreign key (id) references TaiKhoan(id)
);
go

CREATE TABLE QLChiBanThan
(
   MaChi NVARCHAR(50) NOT NULL PRIMARY KEY,
   TenLoaiChi NVARCHAR(50) NOT NULL,
   NgayChi DATE NOT NULL,
   SoTien DECIMAL(10,3) NOT NULL,
   GhiChu NVARCHAR(50),
   id int,
   foreign key (id) references TaiKhoan(id)
);
go

CREATE TABLE QLVay(
Mavay NVarchar(10) PRIMARY KEY,
TenNguoiChoVay NVARCHAR(50),
SoTien MONEY,
NgayVay DATE,
NgayTraDuKien DATE,
LaiSuat DECIMAL(4,2),
id int,
foreign key (id) references TaiKhoan(id),
TienLaiDuKien MONEY);
go 

CREATE TRIGGER Trg
ON QLVay
AFTER INSERT
AS
BEGIN
    DECLARE @NewID NVARCHAR(10)
    SELECT @NewID = 'MV' + RIGHT('0000' + CAST((SELECT MAX(RIGHT(MaVay, 4)) FROM QLVay) + 1 AS NVARCHAR(4)), 4)
    UPDATE QLVay SET MaVay = @NewID WHERE MaVay = (SELECT MaVay FROM inserted)
END

CREATE TABLE QLChoVay(
MaChoVay NVarchar(10) PRIMARY KEY,
TenNguoiVay NVARCHAR(50),
SoTien MONEY,
NgayVay DATE,
NgayTraDuKien DATE,
LaiSuat DECIMAL(4,2),
id int,
foreign key (id) references TaiKhoan(id),
TienLaiDuKien MONEY);
go

CREATE TRIGGER Trg2
ON QLChoVay
AFTER INSERT
AS
BEGIN
    DECLARE @NewID NVARCHAR(10)
    SELECT @NewID = 'MCV' + RIGHT('0000' + CAST((SELECT MAX(RIGHT(MaChoVay, 4)) FROM QLChoVay) + 1 AS NVARCHAR(4)), 4)
    UPDATE QLChoVay SET MaChoVay = @NewID WHERE MaChoVay = (SELECT MaChoVay FROM inserted)
END