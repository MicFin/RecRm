class AddOriginalEntryToReviewConflicts < ActiveRecord::Migration
  def change
    add_column :review_conflicts, :original_entry, :text
  end
end
