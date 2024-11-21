
-- Consulta 1 -- Listar todos los vinos de España. 
-- Muestra el nombre del vino y el nombre de la bodega

SELECT wines.wine, wineries.winery
FROM wines
JOIN wineries ON wines.id_winery = wineries.id_winery;

-- Consulta 2 -- Distribución regional de vinos
-- Muestra el nombre de la región, la cantidad de vinos y el promedio de calificación
SELECT 
    wi.region AS region_name, 
    COUNT(w.id_wine) AS total_wines, 
    AVG(r.rating) AS avg_rating
FROM  wines w
JOIN wineries wi ON w.id_winery = wi.id_winery
JOIN ratings r ON w.id_wine = r.id_wine
GROUP BY wi.region
ORDER BY total_wines DESC;

-- Consulta 3 -- Obtener los tipos de vinos disponible y su cantidad
-- Muestra el nombre del tipo de vino y la cantidad de vinos

SELECT wine_type.wine_type, COUNT(wines.id_wine) AS total_wines
FROM wine_type
LEFT JOIN wines ON wine_type.id_type = wines.id_type
GROUP BY wine_type.wine_type;

-- Consulta 4 -- Vinos con las calificaciones mayores a 4.5
-- Muestra el nombre del vino, la calificación y el nombre de la bodega

SELECT wines.wine, AVG(ratings.rating) AS avg_rating, wineries.winery
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
JOIN wineries ON wines.id_winery = wineries.id_winery
GROUP BY wines.wine, wineries.winery
HAVING avg_rating > 4.5
ORDER BY avg_rating DESC;

-- Consulta 5 -- Promedio de los precios por tipo de vino
-- Muestra el nombre del tipo de vino y el promedio de precio

SELECT wt.wine_type, AVG(r.price) AS avg_price
FROM wine_type wt
JOIN wines w ON wt.id_type = w.id_type
JOIN ratings r ON w.id_wine = r.id_wine
GROUP BY wt.wine_type
ORDER BY avg_price DESC;

-- Consulta 6 -- Promedio de calificaciones en el tipo de vino
-- Muestra el nombre del tipo de vino y el promedio de calificación

SELECT wine_type.wine_type, AVG(ratings.rating) AS avg_rating
FROM wine_type
JOIN wines ON wine_type.id_type = wines.id_type
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wine_type.wine_type;

-- Consulta 7 -- Promedio de calificaciones por tipo de vino y año
-- Muestra el nombre del tipo de vino, el año y el promedio de calificación

SELECT wine_type.wine_type, wines.wine_year, AVG(ratings.rating) AS avg_rating
FROM wine_type
JOIN wines ON wine_type.id_type = wines.id_type
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wine_type.wine_type, wines.wine_year;

-- Consulta 8 -- Bodegas que producen más vino
-- Muestra el nombre de la bodega y la cantidad de vinos

SELECT wineries.winery, COUNT(wines.id_wine) AS total_wines
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
GROUP BY wineries.winery
ORDER BY total_wines DESC;

-- Consulta 9 -- Promedio de calificaciones por bodega
-- Muestra el nombre de la bodega y el promedio de calificación

SELECT wineries.winery, AVG(ratings.rating) AS avg_rating
FROM wineries
JOIN wines ON wineries.id_winery = wines.id_winery
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wineries.winery;

-- Consulta 10 -- El mejor y el peor vino según su calificación y su año
-- Muestra el nombre del vino, la calificación y el año

SELECT 
    'Mejor vino' AS category, 
    w.wine, 
    r.rating, 
    w.wine_year
FROM 
    wines w
JOIN 
    ratings r ON w.id_wine = r.id_wine
WHERE 
    r.rating = (SELECT MAX(rating) FROM ratings)
UNION ALL
SELECT 
    'Peor vino' AS category, 
    w.wine, 
    r.rating, 
    w.wine_year
FROM 
    wines w
JOIN 
    ratings r ON w.id_wine = r.id_wine
WHERE 
    r.rating = (SELECT MIN(rating) FROM ratings);


-- Consulta 11 -- Los 10 vinos con la mayor cantidad de calificaciones y su calificación media
-- Muestra el nombre del vino, la cantidad de calificaciones y la calificación media

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings DESC
LIMIT 10;

-- Consulta 12 -- Los 10 vinos con la menor cantidad de calificaciones y su calificación media

SELECT wines.wine, COUNT(ratings.rating) AS num_ratings, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY num_ratings ASC
LIMIT 10;

-- Consulta 13 -- Los 10 vinos con mejor y peor relación calificación-precio y su calificación media
-- Muestra el nombre del vino, la calificación, el precio y la calificación media

SELECT wines.wine, ratings.rating, ratings.price, AVG(ratings.rating) AS avg_rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine, ratings.rating, ratings.price
ORDER BY ratings.rating / ratings.price DESC
LIMIT 10;

-- Consulta 14 -- Número total de reseñas por denominación de vino y su calificación media
-- Muestra el nombre de la denominación de vino, el número total de reseñas y la calificación media

SELECT designations.designation, SUM(ratings.num_reviews) AS total_reviews, AVG(ratings.rating) AS avg_rating
FROM designations
LEFT JOIN wines ON designations.id_designation = wines.id_designation
LEFT JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY designations.designation;


-- Consulta 15 -- Vinos más antiguos por denominación de vino(sin repetirlas) y su calificación media
-- Muestra el nombre de la denominación de vino, el nombre del vino, el año del vino y la calificación media

SELECT designations.designation, wines.wine, wines.wine_year, AVG(ratings.rating) AS avg_rating
FROM designations
LEFT JOIN wines ON designations.id_designation = wines.id_designation
LEFT JOIN ratings ON wines.id_wine = ratings.id_wine
WHERE wines.wine_year = (
    SELECT MIN(wine_year)
    FROM wines AS sub_wines
    WHERE sub_wines.id_designation = designations.id_designation
)
GROUP BY designations.designation, wines.wine, wines.wine_year
ORDER BY wines.wine_year ASC, designations.designation;

-- Consulta 16 -- Vinos que destacan en cuerpo o acidez
-- Muestra el nombre del vino, el cuerpo, la acidez y la calificación

SELECT wines.wine, ratings.body, ratings.acidity, ratings.rating
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
WHERE ratings.body > 4 OR ratings.acidity > 4
ORDER BY ratings.rating DESC;

-- Consulta 17 -- Distribución de vinos por cuerpo y acidez 
-- Muestra el cuerpo, la acidez y la cantidad de vinos

SELECT ratings.body, ratings.acidity, COUNT(wines.id_wine) AS total_wines
FROM ratings
JOIN wines ON ratings.id_wine = wines.id_wine
GROUP BY ratings.body, ratings.acidity
ORDER BY total_wines DESC;

-- Consulta 18 -- Años con mayor y menor produccion de vinos
-- Muestra el año y la cantidad de vinos

SELECT wines.wine_year, COUNT(wines.id_wine) AS total_wines
FROM wines
GROUP BY wines.wine_year
ORDER BY total_wines DESC;



-- Consulta 19 -- Relación entre cuerpo, acidez y calificación media de vinos
-- Muestra el cuerpo, la acidez y la calificación media

SELECT ratings.body, ratings.acidity, AVG(ratings.rating) AS avg_rating
FROM ratings
GROUP BY ratings.body, ratings.acidity
ORDER BY avg_rating DESC;

-- Consulta 20 -- Distribución de precios por tipo de vino 
-- Muestra el tipo de vino, el precio minimo, el precio maximo y el precio promedio

SELECT wine_type.wine_type, MIN(ratings.price) AS min_price, MAX(ratings.price) AS max_price, AVG(ratings.price) AS avg_price
FROM wine_type
JOIN wines ON wine_type.id_type = wines.id_type
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wine_type.wine_type;

-- Consulta 21 -- Top 5 bodegas con mejor promedio de calificaciones y los vinos elaborados por ellas
-- Muestra el nombre de la bodega, la cantidad de vinos y la calificación media

SELECT w.winery, COUNT(r.id_wine) AS num_wines, AVG(r.rating) AS avg_rating
FROM wineries w
JOIN wines wi ON w.id_winery = wi.id_winery
JOIN ratings r ON wi.id_wine = r.id_wine
GROUP BY w.winery
ORDER BY avg_rating DESC
LIMIT 5;

-- Consulta 22 -- Top 5 vinos con mayor cantidad de reseñas
-- Muestra el nombre del vino y la cantidad de reseñas

SELECT wines.wine, SUM(ratings.num_reviews) AS total_reviews
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY wines.wine
ORDER BY total_reviews DESC
LIMIT 5;

-- Consulta 23 -- Análisis de vinos por rango de calificaciones 
-- Muestra la calificación, la cantidad de vinos, el precio promedio y el porcentaje

SELECT 
    CASE
        WHEN r.rating >= 4.5 THEN 'Excelente'
        WHEN r.rating >= 4 THEN 'Muy bueno'
        WHEN r.rating >= 3.5 THEN 'Bueno'
        WHEN r.rating >= 3 THEN 'Regular'
        ELSE 'Malo'
    END AS rating_category,
    COUNT(*) AS total_wines,
    ROUND(AVG(r.price), 2) AS avg_price,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ratings), 2) AS percentage
FROM ratings r
JOIN wines w ON r.id_wine = w.id_wine
GROUP BY rating_category
ORDER BY percentage DESC;

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

-- Consulta 25 -- Análisis de vinos por rango de calificaciones y precios
-- Muestra la calificación, la cantidad de vinos y el porcentaje  

SELECT 
    CASE
        WHEN ratings.rating >= 4.5 THEN 'Excelente'
        WHEN ratings.rating >= 4 THEN 'Muy bueno'
        WHEN ratings.rating >= 3.5 THEN 'Bueno'
        WHEN ratings.rating >= 3 THEN 'Regular'
        ELSE 'Malo'
    END AS rating_category,
    COUNT(*) AS total_wines,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ratings), 2) AS percentage
FROM wines
JOIN ratings ON wines.id_wine = ratings.id_wine
GROUP BY rating_category
ORDER BY total_wines DESC;

-- Consulta 26 -- Análisis de tendencias de calificaciones y precio por año 
-- Muestra el año y la calificación media

SELECT w.wine_year, AVG(r.rating) AS avg_rating
FROM wines w
JOIN ratings r ON w.id_wine = r.id_wine
GROUP BY w.wine_year
ORDER BY w.wine_year ASC;

-- Consulta 27 -- Correlación entre calificaciones y precios 
-- Muestra el precio y la calificación

SELECT r.price, AVG(r.rating) AS avg_rating
FROM ratings r
GROUP BY r.price
ORDER BY r.price ASC;

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

-- Consulta 30 -- Se unifican las consultas 4, 6, 9, 11 para crear una vista que calcula el promedio de calificaciones a distintos niveles
-- de vino, bodega y tipo

SELECT 
    w.wine,
    wt.wine_type,
    wi.winery,
    AVG(r.rating) AS avg_rating,
    COUNT(r.rating) AS num_ratings
FROM wines w
JOIN ratings r ON w.id_wine = r.id_wine
JOIN wineries wi ON w.id_winery = wi.id_winery
JOIN wine_type wt ON w.id_type = wt.id_type
GROUP BY w.wine, wt.wine_type, wi.winery;

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

-- Consulta 32 -- Múltiples estadísticas para consultar la distribución de vinos por año
-- Muestra el año y la cantidad de vinos

SELECT 
    wines.wine_year,
    COUNT(*) AS total_wines
FROM wines
GROUP BY year
WITH ROLLUP
HAVING wines.wine_year IS NOT NULL -- Excluye la fila total, si no es requerida
ORDER BY total_wines DESC;
