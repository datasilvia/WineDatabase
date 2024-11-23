# **Wine Database Project**

This a proyect for Ironhack's Data Analytics bootcamp.
You can enjoy a visual presentation [here](https://www.canva.com/design/DAGXDdtUPiw/6pFqIfnYYvOwLbpH_AaOXQ/edit)
![Presentation](images/presentacion.jpg "Visual presentation of the project")


## **Table of Contents**
1. [Introduction](#introduction)
2. [Data Collection](#data-collection)
3. [Data Cleaning](#data-cleaning)
4. [Database Design](#database-design)
5. [SQL Queries](#sql-queries)
6. [Visualizations](#visualizations)
7. [Challenges and Conclusions](#challenges-and-conclusions)

---

## **Introduction**

This project focuses on creating a structured database for analyzing wine data. 
The topic was chosen due to the growing interest in wine analytics and the potential to uncover insights about wine characteristics, pricing, and regions.

**Project Objectives**:
- Design a database.
- Clean and prepare the data for structured storage.
- Execute SQL queries to derive insights.
- Visualize key findings using charts and graphs.

---

## **Data Collection**

The dataset used is [Spanish Wine Quality Datase](https://www.kaggle.com/datasets/fedesoriano/spanish-wine-quality-dataset).

It contains details about:
- Wineries and regions.
- Types of wines.
- Wine characteristics like body, acidity, and price.

This dataset was selected for its depth of information and relevance to the topic.

---

## **Data Cleaning**

Before designing the database, the dataset underwent several cleaning steps:

 -Unnecessary columns were removed.

 -Handling missing values.

 -Dropping duplicate entries.

 -Data standardization.


---

## **Database Design**

The database consists of the following tables:

1. Wines
2. Wineries
3. Type
4. Ratings
5. Designations
   

## **ERD diagram** 

![Entity Relationship Diagram](images/ER.png "Entity Relationship Diagram for the Wine Database")

---

## **SQL Queries**

Some of the key SQL queries written during the project include:

1. **Regional distribution of wines**: Shows the region name, the number of wines, and the average rating.
   ```sql
 
    SELECT 
        wi.region AS region_name, 
        COUNT(w.id_wine) AS total_wines, 
        AVG(r.rating) AS avg_rating
    FROM  wines w
    JOIN wineries wi ON w.id_winery = wi.id_winery
    JOIN ratings r ON w.id_wine = r.id_wine
    GROUP BY wi.region
    ORDER BY total_wines DESC;

2. **Relationship between body, acidity, and average wine rating**: Shows the body, acidity, and average rating.
    ```sql

    SELECT ratings.body, ratings.acidity, AVG(ratings.rating) AS avg_rating
    FROM ratings
    GROUP BY ratings.body, ratings.acidity
    ORDER BY avg_rating DESC;


    

## **Visualizations**
Created using Python's Matplotlib.

- **Average rating by region**
![Average rating by region](images/calificacion_promedio.jpg "Average rating by region")

- **Top 50 wineries**
![Top 50 wineries](images/top_bodegas.jpg "Top 50 wineries")

- **Relationship between price category and average ratings**
![Relationship between price category and average ratings](images/categoria_y_calificaciones.jpg "Relationship between price category and average ratings")

- **Evolution of the total number of wines and ratings by year**
![Evolution of the total number of wines and ratings by year](images/evolucion_y_calificacion.jpg "Evolution of the total number of wines and ratings by year")

- **Relationship between body, acidity, and average ratings**
![Relationship between body, acidity, and average ratings](images/cuerpo_acidez.jpg "Relationship between body, acidity, and average ratings")

- **Quality-price ratio**
![Quality-price ratio](images/calidad_precio.jpg "Quality-price ratio")

- **Distribution of ratings by price**
![Distribution of ratings by price](images/calificacion_precio.jpg "Relationship between price category and average ratings")



---

## **Challenges and Conclusions**

### **Challenges**
1. **Theme election**:

- The choice of the topic took longer than expected because the first topic we selected did not have much data available online, so we decided to change the project's theme.
   
2. **Importing existing data from csv files into MySQL WorkBench tables**:

- Using a new tool like MySQL Workbench, we took some time to get familiar with an essential action: importing data from a CSV file into a table in Workbench.
   
3. **Data Integration**:

- Linking the relationships between tables while maintaining data integrity was complex.


---


### **Conclusions**

- SQL is a powerful tool for analyzing relational data in structured domains like wine analytics.
- The structured database lays the foundation for advanced analytics and visualizations.
- Data quality is crucial for meaningful insights: Addressing missing values and standardizing data was essential to ensure accurate analysis and trustworthy results.
- The project demonstrates the potential for further exploration: By combining SQL queries with visualizations, this project sets the stage for deeper insights into wine trends, regional preferences, and consumer behavior.

---

## **Future Improvements**

1. **Additional Data**:
   - Incorporate international wine datasets for a global analysis.
2. **Advanced SQL Queries**:
   - Implement window functions and CTEs for deeper insights.
3. **Interactive Dashboards**:
   - Use tools like Tableau or Power BI for dynamic visualizations.

---


## 👥 Project Members

| Name            | GitHub Profile    |
|-----------------|-------------------|
| Alicia Caminero | [Alicia Caminero](https://github.com/aliciacaminero) |
| Andrea Lafarga  | [Andrea Lafarga](https://github.com/AndreaLaHe)  |
| Gema Villena    | [Gema Villena](https://github.com/GemaVNZ)    |
| Silvia Alonso   | [Silvia Alonso](https://github.com/datasilvia)   |


Feel free to reach out with any question, feedback or contribution to the project!