class AddCategoryToMonologueTagging < ActiveRecord::Migration
  def change
    add_column :monologue_taggings, :category, :string
  end
end
