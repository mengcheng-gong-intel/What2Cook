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
  food_id int PRIMARY KEY,
  food_name varchar UNIQUE NOT NULL,
  foodcategory_id int UNIQUE,
  createdate TIMESTAMPTZ(3),
  author_id int,
  img_url varchar(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS FoodCategories (
foodcategory_id int PRIMARY KEY,
foodcategory_nam varchar UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Materials (
material_id int PRIMARY KEY,
material_nam varchar UNIQUE NOT NULL,
materialcategory_i int NOT NULL
);

CREATE TABLE IF NOT EXISTS Authors (
  author_id int PRIMARY KEY,
  author_name varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS MaterialCategories (
  materialcategory_id int PRIMARY KEY,
  materialcategory_name varchar UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Ingredients (
  ingredient_id int PRIMARY KEY,
  ingredient_name varchar UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS FoodMaterials (
  id int PRIMARY KEY,
  food_id int UNIQUE NOT NULL,
  material_id int NOT NULL
);

CREATE TABLE IF NOT EXISTS FoodIngredients (
  id int PRIMARY KEY,
  food_id int UNIQUE NOT NULL,
  ingredient_id int NOT NULL
);

ALTER TABLE FoodMaterials ADD FOREIGN KEY (food_id) REFERENCES Foods (food_id);

ALTER TABLE FoodMaterials ADD FOREIGN KEY (material_id) REFERENCES Materials (material_id);

ALTER TABLE Foods ADD FOREIGN KEY (author_id) REFERENCES Authors (author_id);

ALTER TABLE FoodIngredients ADD FOREIGN KEY (ingredient_id) REFERENCES Ingredients (ingredient_id);

ALTER TABLE FoodIngredients ADD FOREIGN KEY (food_id) REFERENCES Food (food_id);

ALTER TABLE FoodCategories ADD FOREIGN KEY (foodcategory_id) REFERENCES Foods (foodcategory_id);

ALTER TABLE MaterialCategories ADD FOREIGN KEY (materialcategory_id) REFERENCES Materials (materialcategory_id);
