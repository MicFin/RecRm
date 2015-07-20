module PatientGroupsHelper

  def get_patient_groups!
    @diseases = PatientGroup.diseases

    @intolerances = PatientGroup.intolerances
    @allergies = PatientGroup.allergies
    @symptoms = PatientGroup.symptoms
    @diets = PatientGroup.where(category: "Diet").order(:order)
    # @patient_groups = {}
    # @patient_groups["EoE"] = PatientGroup.where(name:"EoE").first
    # @patient_groups["FPIES"] = PatientGroup.where(name:"FPIES").first
    # @patient_groups["CSID"] = PatientGroup.where(name:"CSID").first
    # @patient_groups["IBS"] = PatientGroup.where(name:"IBS").first
    # @patient_groups["Celiac"] = PatientGroup.where(name:"Celiac Disease").first
    # @patient_groups["Crohns"] = PatientGroup.where(name:"Crohn's Disease").first
    # @patient_groups["IBS"] = PatientGroup.where(name:"IBS").first
    # @patient_groups["Colitis"] = PatientGroup.where(name:"Allergic Colitis").first
    # @patient_groups["Diabetes"] = PatientGroup.where(name:"Diabetes").first

  end

end