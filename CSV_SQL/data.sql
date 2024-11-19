-- Agregar clave primaria a la tabla 'wines'
ALTER TABLE wines
ADD PRIMARY KEY (id);

-- Agregar clave primaria a la tabla 'winery'
ALTER TABLE winerys
ADD PRIMARY KEY (winery_id);

-- Agregar clave foránea a 'winery' (relación con 'wines')
ALTER TABLE winerys
ADD CONSTRAINT fk_winery_wine
FOREIGN KEY (wine_id) REFERENCES wines(id)
ON DELETE CASCADE;

-- Agregar clave foránea a 'winery' (relación con 'region')
ALTER TABLE winerys
ADD CONSTRAINT fk_winery_region
FOREIGN KEY (region_id) REFERENCES region(region_id)
ON DELETE SET NULL;

-- Agregar clave primaria a la tabla 'region'
ALTER TABLE regions
ADD PRIMARY KEY (region_id);

-- Agregar clave primaria a la tabla 'type'
ALTER TABLE designations
ADD PRIMARY KEY (type_id);

-- Agregar clave foránea a 'type' (relación con 'wines')
ALTER TABLE designations
ADD CONSTRAINT fk_type_wine
FOREIGN KEY (wine_id) REFERENCES wines(id)
ON DELETE CASCADE;