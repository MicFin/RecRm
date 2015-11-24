class AddPublicToMonologuePosts < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :public, :boolean
  end
end
