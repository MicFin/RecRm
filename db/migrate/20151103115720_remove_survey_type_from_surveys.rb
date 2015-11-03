class RemoveSurveyTypeFromSurveys < ActiveRecord::Migration
  def change
    remove_column :surveys, :survey_type, :string
  end
end
