class RenameRecipesAttributesTableToRecipesCharacteristics < ActiveRecord::Migration
    def change
        rename_table :recipes_attributes, :recipes_characteristics
    end 
end
