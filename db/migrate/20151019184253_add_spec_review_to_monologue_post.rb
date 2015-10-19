class AddSpecReviewToMonologuePost < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :specs_completed, :boolean
    add_column :monologue_posts, :specs_completed_at, :datetime
  end
end
