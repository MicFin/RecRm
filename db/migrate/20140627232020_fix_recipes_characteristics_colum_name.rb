class FixRecipesCharacteristicsColumName < ActiveRecord::Migration
 def change
    rename_column :recipes_characteristics, :attribute_id, :characteristic_id
  end
end
