

object @recipe
attributes :id, :name, :image_url, :description, :cook_time, :prep_time, :difficulty 
child(:ingredient_list) { attributes :id, :name, child(:ingredient_characteristics) {attributes :amount, :amount_unit, :prep}}
child(:step_list) { attributes :id, :step_number, :directions, child(:ingredient_list) {attributes :name} }
node(:courses) { |recipe| recipe.courses } 
node(:age_groups) { |recipe| recipe.age_groups } 
node(:scenarios) { |recipe| recipe.scenarios } 
node(:holidays) { |recipe| recipe.holidays } 
node(:cultures) { |recipe| recipe.cultures } 
