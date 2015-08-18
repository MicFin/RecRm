module PatientGroupsHelper

  # Requires @user to be defined before calling
  def get_patient_groups!

    # Get common patient groups
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
    @allergies = PatientGroup.allergies
    @symptoms = PatientGroup.symptoms
    @diets = PatientGroup.diets
    binding.pry
    # Check if user has any unverified health groups that should be added to the lists
    @user ||= current_user
    unverified_groups = @user.unverified_health_groups
    if unverified_groups["diseases"].count > 0
        unverified_groups["diseases"].each{|disease| @diseases << disease}
    end
    if unverified_groups["intolerances"].count > 0
        unverified_groups["intolerances"].each{|intolerance| @intolerances << intolerance}
    end
    if unverified_groups["allergies"].count > 0
        unverified_groups["allergies"].each{|allergy| @allergies << allergy}
    end
    if unverified_groups["symptoms"].count > 0
        unverified_groups["symptoms"].each{|symptom| @symptoms << symptom}
    end
    if unverified_groups["diets"].count > 0
        unverified_groups["diets"].each{|diet| @diets << diet}
    end
    binding.pry
  end

end