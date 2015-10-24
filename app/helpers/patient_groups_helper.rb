module PatientGroupsHelper

  # Requires @user to be defined before calling
  def get_patient_groups!

    # Get common patient groups
    @diseases = PatientGroup.diseases
    @intolerances = PatientGroup.intolerances
    @allergies = PatientGroup.allergies
    @symptoms = PatientGroup.symptoms
    @diets = PatientGroup.diets

    # Check if user has any unverified health groups that should be added to the lists
    @user ||= current_user

    unverified_groups = @user.unverified_health_groups
    if unverified_groups["disease"].count > 0
        unverified_groups["disease"].each{|disease| @diseases << disease}
    end
    if unverified_groups["intolerance"].count > 0
        unverified_groups["intolerance"].each{|intolerance| @intolerances << intolerance}
    end
    if unverified_groups["allergy"].count > 0
        unverified_groups["allergy"].each{|allergy| @allergies << allergy}
    end
    if unverified_groups["symptom"].count > 0
        unverified_groups["symptom"].each{|symptom| @symptoms << symptom}
    end
    if unverified_groups["diet"].count > 0
        unverified_groups["diet"].each{|diet| @diets << diet}
    end

  end

end