namespace :updateingredientsrecipe do
  desc "Updates ingredients with no position to 1"
  task update_position: :environment do
    puts "Updating recipes with no position"
    IngredientsRecipe.all.each do |ingredients_recipe|
      if ingredients_recipe.position == nil
        ingredients_recipe.position = 1
      end
      ingredients_recipe.save
    end
  end
  desc "Updates ingredients with no display name"
  task update_display_name: :environment do
    puts "Updating ingredients with no display name"
    IngredientsRecipe.all.each do |ingredients_recipe|
      if ingredients_recipe.display_name == nil
        ingredients_recipe.display_name = ingredients_recipe.ingredient.name
      end
      ingredients_recipe.save
    end
  end

end