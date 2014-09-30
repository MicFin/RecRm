module PatientGroupsHelper

  def get_patient_groups!
    @diseases = PatientGroup.where(category: "disease")
    @intolerances = PatientGroup.where(category: "intolerance", input_option: nil)
    @allergies = PatientGroup.where(category: "allergy", input_option: nil)
    @diets = PatientGroup.where(category: "Diet").order(:order)
  end

end