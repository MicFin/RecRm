class Expertise < ActiveRecord::Base

  # # RELATIONSHIPS
  belongs_to :dietitian
  belongs_to :patient_group

  def self.reset_dietitian_expertise(dietitian)

    # destroy current expertises
    if dietitian.expertises.count >= 1
      dietitian.expertises.map {|expertise| expertise.destroy}
    end

    # Create expertise for diseases
    PatientGroup.diseases.map { |disease| Expertise.create({dietitian_id: dietitian.id, patient_group_id: disease.id}) }

  end
end
