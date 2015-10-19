class AddReviewDetailsToMonologuePosts < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :nutrition_review_completed_at, :datetime
    add_column :monologue_posts, :medical_review_completed_at, :datetime
    add_column :monologue_posts, :culinary_review_completed_at, :datetime
    add_column :monologue_posts, :marketing_review_completed_at, :datetime
    add_column :monologue_posts, :editorial_review_completed_at, :datetime
  end
end
