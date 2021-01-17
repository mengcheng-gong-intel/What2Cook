USE what2cook_dev;

INSERT INTO what2cook_dev.Authors(author_id, author_name) VALUES (1, 'MC'), (2, 'Chris'), (3, 'Wheat');
INSERT INTO what2cook_dev.MaterialCategories(material_category_id, material_category_name) VALUES (1, 'meat'), (2, 'vegetables');
INSERT INTO what2cook_dev.Ingredients(ingredient_id, ingredient_name) VALUES 	(1, 'pepper'), 
																				(2, 'cornstarch'), 
																				(3, 'milk'), 
																				(4, 'Parmesan Cheese'), 
																				(5, 'Crisp Crouton');
INSERT INTO what2cook_dev.Materials(material_id, material_name, material_category_id) VALUES	(1, 'Brocoli', 2), 
																								(2, 'Carrot', 2), 
																								(3, 'Cucumber', 2), 
																								(4, 'Lettuc', 2), 
																								(5, 'Onion', 2), 
																								(6, 'Potato', 2), 
																								(7, 'Tomato', 2), 
																								(8, 'Beef', 1), 
																								(9, 'Chicken', 1), 
																								(10, 'Egg', 1), 
																								(11, 'Shrimp', 1);
INSERT INTO what2cook_dev.FoodCategories(food_category_id, food_category_name) VALUES 	(1, 'main dishes'), 
																						(2, 'soup'), 
																						(3, 'pop food'), 
																						(4, 'salad');
INSERT INTO what2cook_dev.Foods(food_id, food_name, foodcategory_id, createdate, author_id) VALUES 	(1, 'Fired Chicken', 3, '2021-01-16 00:00:00+00:00', 1),
																									(2, 'French Fries', 3, '2021-01-15 00:00:00+00:00', 2),
																									(3, 'Jumbo Shrimp', 1, '2021-01-14 10:00:00+00:00',3),
																									(4, 'Hearty Fall Soup', 2, '2021-01-13 11:30:00+00:00', 2),
																									(5, 'Caesar Salad', 4, '2021-01-15 10:00:00+00:00', 3),
																									(6, 'Classic Meatball', 1, '2021-01-12 10:00:00+00:00', 1),
																									(7, 'Cucumber and Onion Salad', 4, '2021-01-15 08:00:00+00:00',2);
INSERT INTO what2cook_dev.FoodMaterials(food_id, material_id) VALUES (1, 9), (2, 5), (3, 11), (3, 1), (4, 9), (4, 2), (5, 4), (6, 8), (6, 5), (6, 10), (7, 3), (7,5);
INSERT INTO what2cook_dev.FoodIngredients(food_id, ingredient_id) VALUES (3, 1), (4, 2), (5, 4), (5, 5), (6, 3);