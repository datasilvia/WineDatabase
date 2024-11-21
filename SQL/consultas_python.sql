-- Consultas sobre la distribución y el ranking de vinos

-- Consulta 2 -- Obtener los tipos de vinos disponible y su cantidad 

SELECT wine_type.wine_type, COUNT(wines.id_wine) AS total_wines
FROM wine_type
LEFT JOIN wines ON wine_type.id_type = wines.id_type
GROUP BY wine_type.wine_type;

-- Consulta 8 -- Bodegas que producen más vino
-- Muestra el nombre de la bodega y la cantidad de vinos

SELECT wineries.winery, COUNT(wines.id_wine) AS total_wines
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
GROUP BY wineries.winery
ORDER BY total_wines DESC;

-- Consulta 11 -- Los 10 vinos con la mayor cantidad de calificaciones y su calificación media
-- Muestra el nombre del vino, la cantidad de calificaciones y la calificación media

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings DESC
LIMIT 10;

-- Consulta 24 -- Análisis de vinos por rango de precios 
-- Muestra el precio, la cantidad de vinos y el porcentaje

SELECT 
    CASE
        WHEN ratings.price >= 100 THEN 'Expensive'
        WHEN ratings.price >= 50 THEN 'Moderate'
        ELSE 'Affordable'
    END AS price_category,
    COUNT(*) AS total_wines
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY price_category
ORDER BY total_wines DESC;

-- Consultas sobre las relaciones y las comparaciones de vinos

-- Consulta 19 -- Relación entre cuerpo, acidez y calificación media de vinos
-- Muestra el cuerpo, la acidez y la calificación media

SELECT ratings.body, ratings.acidity, AVG(ratings.rating) AS avg_rating
FROM ratings
GROUP BY ratings.body, ratings.acidity
ORDER BY avg_rating DESC;

-- Consulta 27 -- Correlación entre calificaciones y precios 
-- Muestra el precio y la calificación

SELECT r.price, AVG(r.rating) AS avg_rating
FROM ratings r
GROUP BY r.price
ORDER BY r.price ASC;


-- Consulta 29 -- Distribución de precios y relación calidad-precio por tipo de vino 
-- Muestra el tipo de vino, el precio minimo, el precio maximo, el precio promedio y el promedio de calidad-precio

SELECT 
    wt.wine_type,
    MIN(r.price) AS min_price,
    MAX(r.price) AS max_price,
    AVG(r.price) AS avg_price,
    AVG(r.rating / r.price) AS avg_quality_price_ratio
FROM wine_type wt
JOIN wines w ON wt.id_type = w.id_type
JOIN ratings r ON w.id_wine = r.id_wine
GROUP BY wt.wine_type
ORDER BY avg_quality_price_ratio DESC;

-- Consultas sobre las tendencias de vinos

-- Consulta 18 -- Años con mayor y menor produccion de vinos
-- Muestra el año y la cantidad de vinos

SELECT wines.year, COUNT(wines.id_wine) AS total_wines
FROM wines
GROUP BY wines.year
ORDER BY total_wines DESC;

-- Consulta 26 -- Análisis de tendencias de calificaciones y precio por año 
-- Muestra el año y la calificación media

SELECT w.wine_year, AVG(r.rating) AS avg_rating
FROM wines w
JOIN ratings r ON w.id_wine = r.id_wine
GROUP BY w.wine_year
ORDER BY w.wine_year ASC;


-- Consulta de los análisis combinados de vinos

-- Consulta 28 -- Análisis combinado de vinos por rango de calificaciones y precios
-- Muestra la calificación, el precio, la cantidad de vinos, el precio promedio y el porcentaje

SELECT 
    CASE
        WHEN r.rating >= 4.5 THEN 'Excelente'
        WHEN r.rating >= 4 THEN 'Muy bueno'
        WHEN r.rating >= 3.5 THEN 'Bueno'
        WHEN r.rating >= 3 THEN 'Regular'
        ELSE 'Malo'
    END AS rating_category,
    CASE
        WHEN r.price >= 100 THEN 'Expensive'
        WHEN r.price >= 50 THEN 'Moderate'
        ELSE 'Affordable'
    END AS price_category,
    COUNT(*) AS total_wines,
    ROUND(AVG(r.price), 2) AS avg_price,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ratings), 2) AS percentage
FROM ratings r
JOIN wines w ON r.id_wine = w.id_wine
GROUP BY rating_category, price_category
ORDER BY percentage DESC;


-- Consulta 31 -- Se unifican las 8, 9, 21 y 22 para hacer un análisis de las bodegas y vinos destacados según su cantidad de vinos y calificaciones 

SELECT 
    wi.winery,
    COUNT(w.id_wine) AS total_wines,
    AVG(r.rating) AS avg_rating,
    SUM(r.num_reviews) AS total_reviews
FROM wineries wi
JOIN wines w ON wi.id_winery = w.id_winery
JOIN ratings r ON w.id_wine = r.id_wine
GROUP BY wi.winery
ORDER BY avg_rating DESC, total_reviews DESC
LIMIT 5;


