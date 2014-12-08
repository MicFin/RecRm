class ChangeTypetoSurveyType < ActiveRecord::Migration
  def up
    remove_column :surveys, :type
    add_column :surveys, :survey_type, :string
  end
  def down
    add_column :surveys, :type, :string
    remove_column :surveys, :survey_type
  end
end
