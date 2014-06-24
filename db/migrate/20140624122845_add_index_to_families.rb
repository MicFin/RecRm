class AddIndexToFamilies < ActiveRecord::Migration
  def change
  	add_index :families, :head_of_family_id
  end
end
