class AddReviewersToReviewConflicts < ActiveRecord::Migration
  def change
    add_column :review_conflicts, :first_reviewer_id, :integer
    add_column :review_conflicts, :second_reviewer_id, :integer
    add_column :review_conflicts, :third_reviewer_id, :integer
    add_index :review_conflicts, :first_reviewer_id
    add_index :review_conflicts, :second_reviewer_id
    add_index :review_conflicts, :third_reviewer_id
  end
end
