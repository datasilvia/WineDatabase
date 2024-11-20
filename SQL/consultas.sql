-- Consulta 1 -- Obtener los vinos de España 

SELECT wines.wine, wineries.country
FROM wines
JOIN wineries ON wines.id_winery = wineries.id_winery
WHERE wineries.country = 'España';

-- Consulta 2 -- Obtener los tipos de vinos disponible y su cantidad 

SELECT wine_type.wine_type, COUNT(wines.id_wine) AS total_wines
FROM wine_type
LEFT JOIN wines ON wine_type.id_type = wines.id_type
GROUP BY wine_type.wine_type;

-- Consulta 3 -- Vinos con las calificaciones mayores a 4.5

SELECT wines.wine, ratings.rating, wineries.winery
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
JOIN wineries ON wines.id_winery = wineries.id_winery
WHERE ratings.rating > 4.5;

-- Consulta 4 -- Promedio de los precios por tipo de vino

SELECT wine_type.wine_type, AVG(ratings.price) AS avg_price
FROM wine_type
JOIN wines ON wine_type.id_type = wines.id_type
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wine_type.wine_type;

-- Consulta 5 -- Promedio de los precios por pais de origen

SELECT wineries.country, AVG(ratings.price) AS avg_price
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wineries.country;

-- Consulta 6 -- Promedio de los precios por pais de origen y tipo de vino

SELECT wineries.country, wine_type.wine_type, AVG(ratings.price) AS avg_price
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
JOIN wine_type ON wines.id_type = wine_type.id_type
GROUP BY wineries.country, wine_type.wine_type;

-- Consulta 7 -- Promedio de calificaciones por pais de origen y tipo de vino

SELECT wineries.country, wine_type.wine_type, AVG(ratings.rating) AS avg_rating
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
JOIN wine_type ON wines.id_type = wine_type.id_type
GROUP BY wineries.country, wine_type.wine_type; 

-- Consulta 8 -- Promedio de calificaciones por pais de origen, tipo de vino y año

SELECT wineries.country, wine_type.wine_type, wines.year, AVG(ratings.rating) AS avg_rating
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
JOIN wine_type ON wines.id_type = wine_type.id_type
GROUP BY wineries.country, wine_type.wine_type, wines.year;

-- Consulta 9 -- Bodegas que producen más vino 

SELECT wineries.winery, COUNT(wines.id_wine) AS total_wines
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
GROUP BY wineries.winery
ORDER BY total_wines DESC;

-- Consulta 10 -- Bodegas que producen más de un tipo de vino

SELECT wineries.winery, wine_type.wine_type, COUNT(wines.id_wine) AS total_wines
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN wine_type ON wines.id_type = wine_type.id_type
GROUP BY wineries.winery, wine_type.wine_type
HAVING COUNT(wines.id_wine) > 1
ORDER BY total_wines DESC;


-- Consulta 11 -- Bodegas que producen vinos con mayor calificación

SELECT wineries.winery, AVG(ratings.rating) AS avg_rating
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wineries.winery
ORDER BY avg_rating DESC;   

-- Consulta 12 -- Bodegas que producen vinos con una calificación menor a 4.5

SELECT wineries.winery, AVG(ratings.rating) AS avg_rating   
FROM wineries   
JOIN wines ON wineries.id_winery = wines.id_winery   
JOIN ratings ON wines.id_wine = ratings.id_wine   
WHERE ratings.rating < 4.5
GROUP BY wineries.winery;

-- Consulta 13 -- El peor vino según su calificación y su año

SELECT wines.wine, ratings.rating, wines.year
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
WHERE ratings.rating = (SELECT MIN(rating) FROM ratings);

-- Consulta 14 -- El mejor vino según su calificación y su año

SELECT wines.wine, ratings.rating, wines.wine_year
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
WHERE ratings.rating = (SELECT MAX(rating) FROM ratings);

-- Consulta 15 -- Los 10 vinos con la mayor cantidad de calificaciones

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings DESC
LIMIT 10;


-- Consulta 16 -- Los 10 vinos con la menor cantidad de calificaciones

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings
FROM wines  
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings ASC
LIMIT 10;

-- Consulta 17 -- Los 10 vinos con la mayor cantidad de calificaciones y su calificación media

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings DESC
LIMIT 10;

-- Consulta 18 -- Los 10 vinos con la menor cantidad de calificaciones y su calificación media

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings ASC
LIMIT 10;

-- Consulta 19 -- Los 10 vinos con mejor relación calificación-precio 

SELECT wines.wine, ratings.rating, ratings.price
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
ORDER BY ratings.rating / ratings.price DESC
LIMIT 10;

-- Consulta 20 -- Los 10 vinos con peor relación calificación-precio 

SELECT wines.wine, ratings.rating, ratings.price
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
ORDER BY ratings.rating / ratings.price ASC
LIMIT 10;


-- Consulta 21 -- Los 10 vinos con mejor relacion calificación-precio y su calificación media

SELECT wines.wine, ratings.rating, ratings.price, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine, ratings.rating, ratings.price
ORDER BY ratings.rating / ratings.price DESC
LIMIT 10;

-- Consulta 22 -- Los 10 vinos con peor relacion calificación-precio y su calificación media

SELECT wines.wine, ratings.rating, ratings.price, AVG(ratings.rating) AS avg_rating 
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine, ratings.rating, ratings.price
ORDER BY ratings.rating / ratings.price ASC
LIMIT 10;

-- Consulta 23 -- Número total de reseñas por denominación de vino

SELECT designations.designation, SUM(ratings.num_reviews) AS total_reviews
FROM designations
LEFT JOIN wines ON designations.id_designation = wines.id_designation
LEFT JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY designations.designation;

-- Consulta 24 -- Número total de reseñas por denominación de vino y su calificación media

SELECT designations.designation, SUM(ratings.num_reviews) AS total_reviews, AVG(ratings.rating) AS avg_rating
FROM designations
LEFT JOIN wines ON designations.id_designation = wines.id_designation
LEFT JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY designations.designation;


-- Consulta 25 -- Vinos más antiguos por denominación de vino y su calificación media

SELECT designations.designation, wines.wine, wines.wine_year, AVG(ratings.rating) AS avg_rating
FROM designations
LEFT JOIN wines ON designations.id_designation = wines.id_designation
LEFT JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY designations.designation, wines.wine, wines.year
ORDER BY wines.year ASC;

-- Consulta 26 -- Promedio de precios por región dentro de España 

SELECT wineries.region, AVG(ratings.price) AS avg_price
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
WHERE wineries.country = 'España'
GROUP BY wineries.region
ORDER BY avg_price DESC;

-- Consulta 27 -- Vinos que destacan en cuerpo o acidez

SELECT wines.wine, ratings.body, ratings.acidity, ratings.rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
WHERE ratings.body > 8 OR ratings.acidity > 8
ORDER BY ratings.rating DESC;

