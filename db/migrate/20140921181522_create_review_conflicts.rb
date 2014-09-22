class CreateReviewConflicts < ActiveRecord::Migration
  def change
    create_table :review_conflicts do |t|
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

      t.timestamps
    end
  end
end
