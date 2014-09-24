module PatientGroupsHelper

  def get_patient_groups!
    @diseases = PatientGroup.where(category: "disease", input_option: false)
    @intolerances = PatientGroup.where(category: "intolerance", input_option: false)
    @allergies = PatientGroup.where(category: "allergy", input_option: false)
  end

end