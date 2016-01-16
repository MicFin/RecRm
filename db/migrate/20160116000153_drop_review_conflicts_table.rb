class DropReviewConflictsTable < ActiveRecord::Migration

  def change
    drop_table :review_conflicts do |t|
      t.integer :risk_level
      t.string :category
      t.string :item
      t.text :first_suggestion
      t.text :issue
      t.boolean :resolved
      t.text :second_suggestion
      t.text :third_suggestion
      t.integer :review_stage
      t.belongs_to :quality_review 
      t.timestamps null:false
      t.integet :first_reviewer_id
      t.integet :second_reviewer_id
      t.integet :third_reviewer_id
    end
  end

end
