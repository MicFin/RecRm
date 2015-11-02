class SurveysQuestions < ActiveRecord::Migration
  def change
    create_table :surveys_questions do |t|
   
      t.integer :survey_id
      t.integer :question_id
      t.text :answer

      t.timestamps
    end

    add_index :surveys_questions, :survey_id
    add_index :surveys_questions, :question_id
  end
end
