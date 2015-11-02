class AddSurveyGroupToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :survey_group, index: true
  end
end
