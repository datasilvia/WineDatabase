-- Crear la base de datos
CREATE DATABASE wines_quality;

-- Crear la tabla Wineries
CREATE TABLE Wineries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    winery VARCHAR(255) NOT NULL
);

-- Crear la tabla Wines
CREATE TABLE Wines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    wine VARCHAR(255) NOT NULL,
    year YEAR NOT NULL,
    designation VARCHAR(255),
    type VARCHAR(255),
    body DECIMAL(3, 1),
    acidity DECIMAL(3, 1),
    winery_id INT NOT NULL,
    FOREIGN KEY (winery_id) REFERENCES Wineries(id)
);

-- Crear la tabla Reviews
CREATE TABLE Reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    wine_id INT NOT NULL,
    rating DECIMAL(3, 1) NOT NULL,
    num_reviews INT NOT NULL,
    FOREIGN KEY (wine_id) REFERENCES Wines(id)
);

-- Crear la tabla Regions
CREATE TABLE Regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    region VARCHAR(255) NOT NULL
);

-- Crear la tabla Prices
CREATE TABLE Prices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    wine_id INT NOT NULL,
    region_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (wine_id) REFERENCES Wines(id),
    FOREIGN KEY (region_id) REFERENCES Regions(id)
);