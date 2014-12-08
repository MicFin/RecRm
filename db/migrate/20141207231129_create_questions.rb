class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_type
      t.text :content
      t.integer :position
      t.integer :survey_group_question_id
      t.string :survey_group
      t.belongs_to :survey, index: true
      t.text :answer
      t.text :choices 
      t.integer :tier, default: 1
      t.timestamps
    end
  end
end
