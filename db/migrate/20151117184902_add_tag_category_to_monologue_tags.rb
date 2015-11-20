class AddTagCategoryToMonologueTags < ActiveRecord::Migration
  def change
    add_column :monologue_tags, :tag_category, :string
  end
end
