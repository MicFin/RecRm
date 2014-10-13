namespace :updaterecipemodels do
    desc "Updates recipes with no creation stage to stage 5"
 task update_creation_stage: :environment do
    puts "Updating recipes with no creation stage"
    Recipe.all.each do |recipe|
      if recipe.creation_stage == nil
        recipe.creation_stage = 5
      end
      if recipe.completed == nil
        recipe.completed = false
      end
      if recipe.live_recipe == nil
        recipe.live_recipe = false
      end
      recipe.save
    end
  end
end