-- Hotel Chain Table
CREATE TABLE Hotel_Chain (
    Chain_ID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Number_Hotels INT NOT NULL,
    Phone_Number VARCHAR(20),
    Contact_emails VARCHAR(255) NOT NULL
);

-- Central Office Table
CREATE TABLE Central_Office (
    ID_CentOffice SERIAL PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    Chain_ID INT,
    FOREIGN KEY (Chain_ID) REFERENCES Hotel_Chain(Chain_ID) ON DELETE SET NULL
);

-- Hotel Table
CREATE TABLE Hotel (
    ID_Hotel SERIAL PRIMARY KEY,
    Chain_ID INT,
    Name VARCHAR(255) NOT NULL,  -- Added for clarity
    Contact_emails VARCHAR(255) NOT NULL,
    Phone_Number VARCHAR(20),
    Address VARCHAR(255) NOT NULL,
    FOREIGN KEY (Chain_ID) REFERENCES Hotel_Chain(Chain_ID) ON DELETE CASCADE
);

-- Employee Table
CREATE TABLE Employee (
    SSN_SIN VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    ID_Hotel INT,
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE SET NULL
);

-- Customer Table
CREATE TABLE Customer (
    ID_Customer SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Registration_Date DATE NOT NULL,
    Address VARCHAR(255) NOT NULL,
);

-- Room Table
CREATE TABLE Room (
    Room_Number INT,
    ID_Hotel INT,
    Room_Price DECIMAL(10,2) NOT NULL,
    Amenities TEXT,
    Capacity VARCHAR(50),
    Problems TEXT,
    Extendable BOOLEAN NOT NULL,
    View VARCHAR(50),
    Is_Available BOOLEAN DEFAULT TRUE,  -- Added for clarity
    PRIMARY KEY (Room_Number, ID_Hotel),
    FOREIGN KEY (ID_Hotel) REFERENCES Hotel(ID_Hotel) ON DELETE CASCADE
);

-- Renting Table
CREATE TABLE Renting (
    ID_Renting SERIAL PRIMARY KEY,
    ID_Customer INT, 
    ID_Hotel INT,
    Room_Number INT,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer),
    FOREIGN KEY (ID_Hotel, Room_Number) REFERENCES Room(ID_Hotel, Room_Number) ON DELETE CASCADE
);

-- Bookings Table
CREATE TABLE Bookings (
    ID_Booking SERIAL PRIMARY KEY,
    ID_Customer INT,
    ID_Hotel INT,
    Room_Number INT,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Special_Request TEXT,
    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer),
    FOREIGN KEY (ID_Hotel, Room_Number) REFERENCES Room(ID_Hotel, Room_Number) ON DELETE CASCADE
);
