module PatientGroupsHelper

  def get_patient_groups!
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
    @allergies = PatientGroup.allergies
    @diets = PatientGroup.where(category: "Diet").order(:order)
  end

end