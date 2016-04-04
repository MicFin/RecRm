class AddContentTypeToMonologueTag < ActiveRecord::Migration
  def change
    add_column :monologue_tags, :content_type, :string
  end
end
