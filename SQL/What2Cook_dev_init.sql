USE defaultdb;

DROP DATABASE IF EXISTS what2cook_dev CASCADE;

CREATE DATABASE IF NOT EXISTS What2Cook_dev;

USE What2Cook_dev;

DROP TABLE IF EXISTS FoodCategories;
DROP TABLE IF EXISTS FoodMaterial;
DROP TABLE IF EXISTS Ingredients;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS MaterialCategories;
DROP TABLE IF EXISTS Materials;
DROP TABLE IF EXISTS Foods;

CREATE TABLE IF NOT EXISTS Foods (
  id int PRIMARY KEY,
  food_id int UNIQUE NOT NULL,
  food_name varchar UNIQUE NOT NULL,
  foodcategory_id int,
  createdate varchar(255),
  author_id int,
  img_url varchar(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS FoodCategories (
  id int PRIMARY KEY,
  foodcategory_id int UNIQUE NOT NULL,
  foodcategory_name varchar UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Materials (
  id int PRIMARY KEY,
  material_id int UNIQUE NOT NULL,
  material_name varchar UNIQUE NOT NULL,
  materialcategory_id int NOT NULL
);

CREATE TABLE IF NOT EXISTS Authors (
  id int PRIMARY KEY,
  author_id int UNIQUE NOT NULL,
  author_name varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS MaterialCategories (
  id int PRIMARY KEY,
  materialcategory_id int UNIQUE NOT NULL,
  materialcategory_name varchar UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Ingredients (
  id int PRIMARY KEY,
  ingredient_id int UNIQUE NOT NULL,
  ingredient_name varchar UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS FoodMaterials (
  id int PRIMARY KEY,
  food_id int NOT NULL,
  material_id int NOT NULL
);

CREATE TABLE IF NOT EXISTS FoodIngredients (
  id int PRIMARY KEY,
  food_id int NOT NULL,
  ingredient_id int NOT NULL
);

CREATE INDEX id_idx ON foodmaterials (food_id ASC);

CREATE INDEX id_idx ON foodingredients (food_id ASC);

ALTER TABLE FoodMaterials ADD FOREIGN KEY (food_id) REFERENCES Foods (food_id);

ALTER TABLE FoodMaterials ADD FOREIGN KEY (material_id) REFERENCES Materials (material_id);

ALTER TABLE Foods ADD FOREIGN KEY (author_id) REFERENCES Authors (author_id);

ALTER TABLE FoodIngredients ADD FOREIGN KEY (ingredient_id) REFERENCES Ingredients (ingredient_id);

ALTER TABLE FoodIngredients ADD FOREIGN KEY (food_id) REFERENCES Foods (food_id);

ALTER TABLE Foods ADD FOREIGN KEY (foodcategory_id) REFERENCES FoodCategories (foodcategory_id);

ALTER TABLE Materials ADD FOREIGN KEY (materialcategory_id) REFERENCES MaterialCategories (materialcategory_id);