class AddSurveyGroupToSurveys < ActiveRecord::Migration
  def change
    add_reference :surveys, :survey_group, index: true, foreign_key: true
  end
end
