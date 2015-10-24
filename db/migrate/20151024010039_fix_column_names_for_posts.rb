class FixColumnNamesForPosts < ActiveRecord::Migration
 def change

    change_table :monologue_posts do |t|

      t.rename :marketing_review, :marketing_review_required
      t.rename :nutrition_review, :nutrition_review_required
      t.rename :culinary_review, :culinary_review_required
      t.rename :medical_review, :medical_review_required

      t.rename :editor_approved, :editorial_initial_review_required
      t.rename :editorial_review_completed_at, :editorial_initial_review_completed_at

      t.column :marketing_review_complete, :boolean, default: false
      t.column :nutrition_review_complete, :boolean, default: false
      t.column :culinary_review_complete, :boolean, default: false
      t.column :medical_review_complete, :boolean, default: false

      t.column :editorial_initial_review_complete, :boolean, default: false

      t.column :editorial__final_review_required, :boolean, default: true
      t.column :editorial_final_review_complete, :boolean, default: false
      t.column :editorial_final_review_completed_at, :datetime

      t.column :marketing_reviewer_id, :integer
      t.column :editorial_initial_reviewer, :integer
      t.column :editorial_final_reviewer, :integer
      t.column :nutrition_reviewer_id, :integer
      t.column :culinary_reviewer_id, :integer
      t.column :medical_reviewer_id, :integer
      t.column :editorial_reviewer_id, :integer
      t.column :spec_author_id, :integer
      t.column :call_to_action_activated, :boolean
    end
  end
end
