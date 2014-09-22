class ChangeColumnsAndTypeForQualityReview < ActiveRecord::Migration
  def change
    remove_column :quality_reviews, :date_due_by
    remove_column :quality_reviews, :date_completed_on
    remove_column :quality_reviews, :type
    remove_column :quality_reviews, :sub_type
    add_column :quality_reviews, :date_due_by, :datetime
    add_column :quality_reviews, :date_completed_on, :datetime
    add_column :quality_reviews, :passed, :boolean
    add_column :quality_reviews, :completed, :boolean

  end
end
