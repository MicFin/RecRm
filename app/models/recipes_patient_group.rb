class RecipesPatientGroup < ActiveRecord::Base
  belongs_to :recipe_id
  belongs_to :patient_group_id


end
