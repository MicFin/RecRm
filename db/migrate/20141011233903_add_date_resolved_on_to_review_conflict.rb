class AddDateResolvedOnToReviewConflict < ActiveRecord::Migration
  def change
    add_column :review_conflicts, :date_resolved_on, :datetime
  end
end
