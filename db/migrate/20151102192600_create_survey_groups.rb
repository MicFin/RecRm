class CreateSurveyGroups < ActiveRecord::Migration
  def change
    create_table :survey_groups do |t|
      t.string :name
      t.integer :version_number

      t.timestamps
    end
  end
end
