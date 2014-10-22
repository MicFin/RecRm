class AddAttributesToReviewConflict < ActiveRecord::Migration
  def change
    add_column :review_conflicts, :fourth_suggestion, :text
    add_column :review_conflicts, :fourth_reviewer_notes, :text
    add_column :review_conflicts, :fourth_reviewer_id, :integer

    add_index :review_conflicts, :fourth_reviewer_id
  end
end
