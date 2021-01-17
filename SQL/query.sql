with fm as (
    select c.food_name, c.img_url, a.food_id, a.material_id, b.material_name
    from FoodMaterials a join
        Materials b
        on a.material_id = b.material_id
		join
		Foods c
		on c.food_id = a.food_id
)
select fm.food_name, fm.img_url, array_agg(distinct material_name) as groups from fm
    group by fm.food_name, fm.img_url;