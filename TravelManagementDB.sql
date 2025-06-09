-- FINAL FULLY NORMALIZED SQL SCHEMA FOR TravelManagementDB

CREATE DATABASE TravelManagementDB;
GO
USE TravelManagementDB;
GO

-- 1. ROLES & USERS
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(20) UNIQUE NOT NULL CHECK (RoleName IN ('CEO', 'Employee'))
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID INT NOT NULL,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- 2. TRAVEL GROUPS & CUSTOMERS
CREATE TABLE TravelGroups (
    GroupID INT PRIMARY KEY IDENTITY(1,1),
    GroupName VARCHAR(100),
    DestinationCountry VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(20) CHECK (Status IN ('Open', 'Closed', 'Cancelled')),
    CreatedBy INT,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100),
    PassportNumber VARCHAR(20) UNIQUE,
    Nationality VARCHAR(50),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    ServiceType VARCHAR(20) CHECK (ServiceType IN ('Group', 'Individual')),
    GroupID INT,
    FOREIGN KEY (GroupID) REFERENCES TravelGroups(GroupID)
);

-- 3. FLIGHTS
CREATE TABLE Airlines (
    AirlineID INT PRIMARY KEY IDENTITY(1,1),
    AirlineName VARCHAR(100)
);

CREATE TABLE BookingStatuses (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(20) -- Confirmed, Pending, Cancelled
);

CREATE TABLE Flights (
    FlightID INT PRIMARY KEY IDENTITY(1,1),
    AirlineID INT,
    FlightNumber VARCHAR(20),
    DestinationCountry VARCHAR(50),
    DepartureDate DATETIME,
    ArrivalDate DATETIME,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);

CREATE TABLE FlightBookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    FlightID INT,
    TicketPrice DECIMAL(10,2),
    DiscountApplied DECIMAL(10,2),
    BookingStatusID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (BookingStatusID) REFERENCES BookingStatuses(StatusID)
);

-- 4. HOTELS & ROOMS
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY IDENTITY(1,1),
    HotelName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE RoomCategories (
    RoomCategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(30)
);

CREATE TABLE HotelRooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    HotelID INT,
    RoomCategoryID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID),
    FOREIGN KEY (RoomCategoryID) REFERENCES RoomCategories(RoomCategoryID)
);

CREATE TABLE HotelBookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES HotelRooms(RoomID)
);

-- 5. MEALS
CREATE TABLE MealTypes (
    MealTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName VARCHAR(50)
);

CREATE TABLE MealVendors (
    VendorID INT PRIMARY KEY IDENTITY(1,1),
    VendorName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE HotelBookingMeals (
    ID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT,
    MealTypeID INT,
    VendorID INT,
    Cost DECIMAL(10,2),
    FOREIGN KEY (BookingID) REFERENCES HotelBookings(BookingID),
    FOREIGN KEY (MealTypeID) REFERENCES MealTypes(MealTypeID),
    FOREIGN KEY (VendorID) REFERENCES MealVendors(VendorID)
);

-- 6. TRANSPORT
CREATE TABLE TransportTypes (
    TypeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) -- e.g., Private, Bus
);

CREATE TABLE VehicleTypes (
    VehicleTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName VARCHAR(50)
);

CREATE TABLE TransportVendors (
    VendorID INT PRIMARY KEY IDENTITY(1,1),
    VendorName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE TransportBookings (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    TypeID INT,
    VehicleTypeID INT,
    VendorID INT,
    Cost DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TypeID) REFERENCES TransportTypes(TypeID),
    FOREIGN KEY (VehicleTypeID) REFERENCES VehicleTypes(VehicleTypeID),
    FOREIGN KEY (VendorID) REFERENCES TransportVendors(VendorID)
);

-- 7. VISAS
CREATE TABLE VisaStatuses (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(20)
);

CREATE TABLE VisaVendors (
    VendorID INT PRIMARY KEY IDENTITY(1,1),
    VendorName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE VisaCountries (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName VARCHAR(50),
    RequiresVendor BIT
);

CREATE TABLE VisaApplications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    CountryID INT,
    ApplicationDate DATE,
    ApprovalDate DATE,
    StatusID INT,
    VendorID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CountryID) REFERENCES VisaCountries(CountryID),
    FOREIGN KEY (StatusID) REFERENCES VisaStatuses(StatusID),
    FOREIGN KEY (VendorID) REFERENCES VisaVendors(VendorID)
);

-- 8. SYRIA TICKETS
CREATE TABLE TicketVendors (
    VendorID INT PRIMARY KEY IDENTITY(1,1),
    VendorName VARCHAR(100)
);

CREATE TABLE SyriaTickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    VendorID INT,
    PurchasePrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2),
    ProfitMargin AS (SellingPrice - PurchasePrice),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (VendorID) REFERENCES TicketVendors(VendorID)
);

-- 9. EXPENSES
CREATE TABLE ServiceCategories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50)
);

CREATE TABLE Expenses (
    ExpenseID INT PRIMARY KEY IDENTITY(1,1),
    GroupID INT,
    CategoryID INT,
    RelatedEntityID INT,
    Amount DECIMAL(10,2),
    Date DATE,
    FOREIGN KEY (GroupID) REFERENCES TravelGroups(GroupID),
    FOREIGN KEY (CategoryID) REFERENCES ServiceCategories(CategoryID)
);

-- 10. LOGGING
CREATE TABLE BookingLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    TableName VARCHAR(50),
    RowID INT,
    Action VARCHAR(100),
    Timestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- 11. VISA COUNTRIES DATA (with Vendor Rules)
INSERT INTO VisaCountries (CountryName, RequiresVendor)
VALUES
('Australia', 0),
('United Kingdom', 0),
('United States', 0),
('China', 1),
('Russia', 1),
('Türkiye', 0),
('France', 0),
('Germany', 0),
('Italy', 0),
('Spain', 0),
('Netherlands', 0),
('Switzerland', 0),
('Greece', 0),
('Austria', 0),
('Belgium', 0),
('Sweden', 0),
('Norway', 0),
('Finland', 0),
('Denmark', 0),
('Poland', 0),
('Syria', 1),
('Saudi Arabia', 1),
('UAE', 0),
('Qatar', 0),
('Jordan', 1);


-- Insert roles
INSERT INTO Roles (RoleName)
VALUES ('CEO'), ('Employee');

-- Insert sample CEO and Employee
-- Replace HASH_HERE with output from Python script
INSERT INTO Users (Username, PasswordHash, RoleID)
VALUES 
('ceo1', '$2b$12$tf1sxnI68FyFM69MiuY44uyXn2aT3uYdUHoJJ/y9x/wNC/KxzEJdi', 1),
('emp1', '$2b$12$Csi.DxvHhOdAfFnTLSD6.uQeqwHCfXynoTSlGCrcnPnAWBWYkK76e', 2);
