class AddDetailsToMonologuePosts < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :nutrition_review, :boolean, default: false
    add_column :monologue_posts, :culinary_review, :boolean, default: false
    add_column :monologue_posts, :medical_review, :boolean, default: false
    add_column :monologue_posts, :marketing_review, :boolean, default: false
    add_column :monologue_posts, :editor_approved, :boolean, default: false
    add_column :monologue_posts, :final_sign_off_date, :datetime
  end
end
