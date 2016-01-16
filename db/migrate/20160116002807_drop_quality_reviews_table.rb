class DropQualityReviewsTable < ActiveRecord::Migration
  def change
    drop_table :quality_reviews do |t|
      t.integer  :dietitian_id
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :quality_reviewable_id
      t.string   :quality_reviewable_type
      t.datetime :date_due_by
      t.datetime :date_completed_on
      t.boolean  :passed
      t.boolean  :completed,              default: false, null: false
      t.datetime :date_started
      t.integer  :tier,                    default: 1
      t.boolean  :resolved,                default: false
      t.datetime :date_resolved_on
    end
  end
end
