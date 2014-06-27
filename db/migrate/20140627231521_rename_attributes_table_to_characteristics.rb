class RenameAttributesTableToCharacteristics < ActiveRecord::Migration
    def change
      rename_table :attributes, :characteristics
    end 
end
