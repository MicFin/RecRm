class RenameRecipesCharacteristicsTableToCharacteristicsRecipes < ActiveRecord::Migration
    def change
      rename_table :recipes_characteristics, :characteristics_recipes
    end 
end
