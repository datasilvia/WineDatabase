CREATE DATASCHEMA WinesBD;

CREATE TABLE wineries (
    id_winery INT AUTO_INCREMENT PRIMARY KEY,
    winery VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    region VARCHAR(100)
);

CREATE TABLE types (
    id_type INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE designations (
    id_designation INT AUTO_INCREMENT PRIMARY KEY,
    designation VARCHAR(255)
);

CREATE TABLE wines (
    id_wine INT AUTO_INCREMENT PRIMARY KEY,
    wine VARCHAR(255) NOT NULL,
    year INT,
    id_winery INT NOT NULL,
    id_type INT NOT NULL,
    id_designation INT
);

CREATE TABLE ratings (
    id_rating INT AUTO_INCREMENT PRIMARY KEY,
    id_wine INT NOT NULL,
    rating FLOAT NOT NULL,
    num_reviews INT,
    price FLOAT,
    body INT,
    acidity INT
);


-- Añadir las claves foráneas a la tabla 'wines'
ALTER TABLE wines
ADD CONSTRAINT fk_winery
FOREIGN KEY (id_winery) REFERENCES wineries(id_winery);

ALTER TABLE wines
ADD CONSTRAINT fk_type
FOREIGN KEY (id_type) REFERENCES types(id_type);

ALTER TABLE wines
ADD CONSTRAINT fk_designation
FOREIGN KEY (id_designation) REFERENCES designations(id_designation);

-- Añadir la clave foránea a la tabla 'ratings'
ALTER TABLE ratings
ADD CONSTRAINT fk_wine
FOREIGN KEY (id_wine) REFERENCES wines(id_wine);