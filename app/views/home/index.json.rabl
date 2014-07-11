

collection @filtered_recipes
attributes :id, :name, :image_url 
child(:ingredient_list) { attributes :id, :name}
child(:step_list) { attributes :id }
child(:characteristic_list) { attributes :category, :name }
