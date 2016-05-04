class AddMainImageUrlToMonologuePost < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :main_image_url, :string
  end
end
