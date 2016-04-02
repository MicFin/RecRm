class RemoveColumnsFromMonologuePost < ActiveRecord::Migration
  def change
    remove_column :monologue_posts, :nutrition_review_required, :boolean
    remove_column :monologue_posts, :culinary_review_required, :boolean
    remove_column :monologue_posts, :medical_review_required,  :boolean 
    remove_column :monologue_posts, :marketing_review_required, :boolean
    remove_column :monologue_posts, :editorial_initial_review_required, :boolean
    remove_column :monologue_posts, :final_sign_off_date, :datetime
    remove_column :monologue_posts, :call_to_action_id, :integer
    remove_column :monologue_posts, :nutrition_review_completed_at,  :datetime
    remove_column :monologue_posts, :medical_review_completed_at,  :datetime
    remove_column :monologue_posts, :culinary_review_completed_at,  :datetime
    remove_column :monologue_posts, :marketing_review_completed_at,  :datetime
    remove_column :monologue_posts, :editorial_initial_review_completed_at,  :datetime
    remove_column :monologue_posts, :specs, :text
    remove_column :monologue_posts, :specs_completed
    remove_column :monologue_posts, :specs_completed_at,  :datetime
    remove_column :monologue_posts, :marketing_review_complete, :boolean
    remove_column :monologue_posts, :nutrition_review_complete, :boolean
    remove_column :monologue_posts, :culinary_review_complete,  :boolean
    remove_column :monologue_posts, :medical_review_complete,  :boolean 
    remove_column :monologue_posts, :editorial_initial_review_complete,  :boolean
    remove_column :monologue_posts, :editorial_final_review_required,   :boolean
    remove_column :monologue_posts, :editorial_final_review_complete,   :boolean 
    remove_column :monologue_posts, :editorial_final_review_completed_at,  :datetime
    remove_column :monologue_posts, :marketing_reviewer_id, :integer
    remove_column :monologue_posts, :editorial_initial_reviewer_id, :integer
    remove_column :monologue_posts, :nutrition_reviewer_id, :integer
    remove_column :monologue_posts, :culinary_reviewer_id, :integer
    remove_column :monologue_posts, :medical_reviewer_id, :integer
    remove_column :monologue_posts, :editorial_final_reviewer_id, :integer
    remove_column :monologue_posts, :spec_author_id
    remove_column :monologue_posts, :call_to_action_activated, :boolean
    remove_column :monologue_posts, :author_complete, :boolean
    remove_column :monologue_posts, :author_completed_at,  :datetime
  end
end
