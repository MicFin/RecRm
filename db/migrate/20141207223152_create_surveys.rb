class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :type
      t.belongs_to :user, index: true
      t.integer :surveyable_id
      t.string :surveyable_type
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
