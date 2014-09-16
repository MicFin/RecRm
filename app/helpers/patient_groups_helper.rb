module PatientGroupsHelper

  def get_patient_groups!
    @diseases = PatientGroup.where(category: "disease")
    @intolerances = PatientGroup.where(category: "intolerance")
    @allergies = PatientGroup.where(category: "allergy")
  end

end