class AddMoreToReviewConflicts < ActiveRecord::Migration
  def change
    add_column :review_conflicts, :first_reviewer_notes, :text
    add_column :review_conflicts, :second_reviewer_notes, :text
    add_column :review_conflicts, :third_reviewer_notes, :text
  end
end
