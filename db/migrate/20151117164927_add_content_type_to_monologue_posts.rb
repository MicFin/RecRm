class AddContentTypeToMonologuePosts < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :content_type, :string
  end
end
