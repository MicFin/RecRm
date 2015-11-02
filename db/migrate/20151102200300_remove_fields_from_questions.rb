class RemoveFieldsFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :survey_group_question_id, :integer
    remove_column :questions, :survey_group, :string
    remove_column :questions, :survey_id, :integer
    remove_column :questions, :answer, :text
  end
end
