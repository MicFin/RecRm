class CreateQualityReviews < ActiveRecord::Migration
  def change
    create_table :quality_reviews do |t|
      t.string :date_due_by
      t.string :date_completed_on
      t.string :type
      t.string :sub_type
      t.belongs_to :dietitian, index: true

      t.timestamps
    end
  end
end
