module PatientGroupsHelper

  def get_patient_groups!
    @diseases = PatientGroup.where(category: "disease", input_option: nil)
    @intolerances = PatientGroup.where(category: "intolerance", input_option: nil)
    @allergies = PatientGroup.where(category: "allergy", input_option: nil)
  end

end