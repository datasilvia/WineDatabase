-- 1. Agregar clave primaria a la tabla 'wines'
ALTER TABLE wines
ADD PRIMARY KEY (id);

-- 2. Agregar clave primaria a la tabla 'winerys'
ALTER TABLE winerys
ADD PRIMARY KEY (winery_id);

-- 3. Relacionar la tabla 'winerys' con 'wines' mediante una clave foránea
ALTER TABLE winerys
ADD CONSTRAINT fk_winery_wine
FOREIGN KEY (wine_id) REFERENCES wines(id)
ON DELETE CASCADE;

-- 4. Relacionar la tabla 'winerys' con 'regions' mediante una clave foránea
ALTER TABLE winerys
ADD CONSTRAINT fk_winery_region
FOREIGN KEY (region_id) REFERENCES regions(region_id)
ON DELETE SET NULL;

-- 5. Agregar clave primaria a la tabla 'regions'
ALTER TABLE regions
ADD PRIMARY KEY (region_id);

-- 6. Agregar clave primaria a la tabla 'designations'
ALTER TABLE designations
ADD PRIMARY KEY (type_id);

-- 7. Relacionar la tabla 'designations' con 'wines' mediante una clave foránea
ALTER TABLE designations
ADD CONSTRAINT fk_type_wine
FOREIGN KEY (wine_id) REFERENCES wines(id)
ON DELETE CASCADE;