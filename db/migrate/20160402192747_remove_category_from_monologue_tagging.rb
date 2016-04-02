class RemoveCategoryFromMonologueTagging < ActiveRecord::Migration
  def change
    remove_column :monologue_taggings, :category, :string
  end
end
