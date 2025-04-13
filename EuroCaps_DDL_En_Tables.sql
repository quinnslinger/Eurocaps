
-- Euro Caps: MySQL DDL + Data-import

-- DATABASE AANMAKEN
CREATE DATABASE IF NOT EXISTS eurocaps;
USE eurocaps;

-- TABELSTRUCTUREN (DDL)

-- SoortPartner
CREATE TABLE IF NOT EXISTS SoortPartner (
    SoortPartnerID INT PRIMARY KEY,
    Omschrijving VARCHAR(100)
);

-- SoortProduct
CREATE TABLE IF NOT EXISTS SoortProduct (
    SoortProductID INT PRIMARY KEY,
    Omschrijving VARCHAR(100),
    Gewicht DECIMAL(10,2),
    Afmeting VARCHAR(50),
    Materiaal VARCHAR(100)
);

-- Partner
CREATE TABLE IF NOT EXISTS Partner (
    PartnerID INT PRIMARY KEY AUTO_INCREMENT,
    Bedrijfsnaam VARCHAR(100),
    Straatnaam VARCHAR(100),
    Huisnummer VARCHAR(10),
    Postcode VARCHAR(10),
    Plaats VARCHAR(50),
    Land VARCHAR(50),
    Email VARCHAR(100),
    TelNr VARCHAR(20),
    SoortPartnerID INT,
    FOREIGN KEY (SoortPartnerID) REFERENCES SoortPartner(SoortPartnerID)
);

-- PartnerContact
CREATE TABLE IF NOT EXISTS PartnerContact (
    PartnerContactID INT PRIMARY KEY AUTO_INCREMENT,
    Voornaam VARCHAR(50),
    Achternaam VARCHAR(50),
    Functie VARCHAR(50),
    Email VARCHAR(100),
    TelNr VARCHAR(20),
    PartnerID INT,
    FOREIGN KEY (PartnerID) REFERENCES Partner(PartnerID)
);

-- Product
CREATE TABLE IF NOT EXISTS Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductTHTDatum DATE,
    CStatusProduct VARCHAR(20),
    FStatusProduct VARCHAR(20),
    PStatusProduct VARCHAR(20),
    SoortProductID INT,
    FOREIGN KEY (SoortProductID) REFERENCES SoortProduct(SoortProductID)
);

-- Batch
CREATE TABLE IF NOT EXISTS Batch (
    BatchID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    BatchCode VARCHAR(50) UNIQUE,
    ProductieDatum DATE,
    Vervaldatum DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Levering
CREATE TABLE IF NOT EXISTS Levering (
    LeveringID INT PRIMARY KEY AUTO_INCREMENT,
    LeveringDatum DATE,
    VerwachteLeverdatum DATE
);

-- LeveringRegel
CREATE TABLE IF NOT EXISTS LeveringRegel (
    LeveringID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (LeveringID, ProductID),
    FOREIGN KEY (LeveringID) REFERENCES Levering(LeveringID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Grinding
CREATE TABLE IF NOT EXISTS Grinding (
    GrindingID INT PRIMARY KEY AUTO_INCREMENT,
    G_DatumTijdStart DATETIME,
    G_DatumTijdEind DATETIME,
    G_Machine VARCHAR(50),
    Capaciteit DECIMAL(6,2)
);

-- Grinding_Product
CREATE TABLE IF NOT EXISTS Grinding_Product (
    GrindingID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (GrindingID, ProductID),
    FOREIGN KEY (GrindingID) REFERENCES Grinding(GrindingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Filling
CREATE TABLE IF NOT EXISTS Filling (
    FillingID INT PRIMARY KEY AUTO_INCREMENT,
    F_DatumTijdStart DATETIME,
    F_DatumTijdEind DATETIME,
    F_Machine VARCHAR(50),
    Capaciteit DECIMAL(6,2)
);

-- Filling_Product
CREATE TABLE IF NOT EXISTS Filling_Product (
    FillingID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (FillingID, ProductID),
    FOREIGN KEY (FillingID) REFERENCES Filling(FillingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Packaging
CREATE TABLE IF NOT EXISTS Packaging (
    PackagingID INT PRIMARY KEY AUTO_INCREMENT,
    P_DatumTijdStart DATETIME,
    P_DatumTijdEind DATETIME,
    P_Machine VARCHAR(50),
    AantalStuksInDoos INT,
    Capaciteit DECIMAL(6,2)
);

-- Packaging_Product
CREATE TABLE IF NOT EXISTS Packaging_Product (
    PackagingID INT,
    ProductID INT,
    Aantal INT,
    PRIMARY KEY (PackagingID, ProductID),
    FOREIGN KEY (PackagingID) REFERENCES Packaging(PackagingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
