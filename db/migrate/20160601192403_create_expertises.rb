class CreateExpertises < ActiveRecord::Migration
  def change
    create_table :expertises do |t|
      t.integer :dietitian_preference
      t.integer :dietitian_qualification
      t.belongs_to :dietitian, index: true
      t.belongs_to :patient_group, index: true
      t.timestamps
    end
  end
end
