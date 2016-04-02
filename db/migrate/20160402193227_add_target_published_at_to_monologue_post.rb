class AddTargetPublishedAtToMonologuePost < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :target_published_at, :datetime
  end
end
