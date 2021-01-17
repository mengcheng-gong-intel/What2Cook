USE what2cook_dev;

INSERT INTO what2cook_dev.Authors(id, author_id, author_name) VALUES (1, 1, 'MC'), (2, 2, 'Chris'), (3, 3, 'Wheat');
INSERT INTO what2cook_dev.MaterialCategories(id, materialcategory_id, materialcategory_name) VALUES (1, 1, 'meat'), (2, 2, 'vegetables');
INSERT INTO what2cook_dev.Ingredients(id, ingredient_id, ingredient_name) VALUES 	(1, 1, 'pepper'), 
																				(2, 2, 'cornstarch'), 
																				(3, 3, 'milk'), 
																				(4, 4, 'Parmesan Cheese'), 

																				(5, 5, 'Crisp Crouton');
INSERT INTO what2cook_dev.Materials(id, material_id, material_name, materialcategory_id) VALUES	(1, 1, 'Brocoli', 2), 
																								(2, 2, 'Carrot', 2), 
																								(3, 3, 'Cucumber', 2), 
																								(4, 4,'Lettuc', 2), 
																								(5, 5, 'Onion', 2), 
																								(6, 6, 'Potato', 2), 
																								(7, 7, 'Tomato', 2), 
																								(8, 8, 'Beef', 1), 
																								(9, 9, 'Chicken', 1), 
																								(10, 10, 'Egg', 1), 
																								(11, 11, 'Shrimp', 1);

INSERT INTO what2cook_dev.FoodCategories(id, foodcategory_id, foodcategory_name) VALUES 	(1, 1, 'main dishes'), 
																						(2, 2, 'soup'), 
																						(3, 3, 'pop food'), 
																						(4, 4, 'salad');

INSERT INTO what2cook_dev.Foods(id, food_id, food_name, foodcategory_id, createdate, author_id, img_url) VALUES 	(1, 1, 'Fired Chicken', 3, '2021-01-16 00:00:00+00:00', 1, 'https://storage.googleapis.com/what2cook/Fired-Chicken.jpeg'),
																									(2, 2, 'French Fries', 3, '2021-01-15 00:00:00+00:00', 2, 'https://storage.googleapis.com/what2cook/French-Fries.jpg'),
																									(3, 3, 'Jumbo Shrimp', 1, '2021-01-14 10:00:00+00:00',3, 'https://storage.googleapis.com/what2cook/classic-meatballs.jpg'),
																									(5, 5, 'Caesar Salad', 4, '2021-01-15 10:00:00+00:00', 3, 'https://storage.googleapis.com/what2cook/Caesar-Salad.jpg'),
																									(7, 7, 'Cucumber and Onion Salad', 4, '2021-01-15 08:00:00+00:00',2, 'https://storage.googleapis.com/what2cook/Cucumber-and-Onion-Salad.jpg'),
																									(8, 8, 'Beef and Potato', 1, '2021-01-15 09:00:00+00:00', 3, 'https://storage.googleapis.com/what2cook/Beef-and-potato.jpg');

INSERT INTO what2cook_dev.Foods(id, food_id, food_name, foodcategory_id, createdate, author_id) VALUES 	(4, 4, 'Hearty Fall Soup', 2, '2021-01-13 11:30:00+00:00', 2), 
																										(6, 6, 'Classic Meatball', 1, '2021-01-12 10:00:00+00:00', 1);
INSERT INTO what2cook_dev.FoodMaterials(id, food_id, material_id) VALUES (1, 1, 9), (2, 2, 5), (3, 3, 11), (4, 3, 1), (5, 4, 9), (6, 4, 2), (7, 5, 4), (8, 6, 8), (9, 6, 5), (10, 6, 10), (11, 7, 3), (12, 7,5);
INSERT INTO what2cook_dev.FoodIngredients(id, food_id, ingredient_id) VALUES (1, 3, 1), (2, 4, 2), (3, 5, 4), (4, 5, 5), (5, 6, 3);