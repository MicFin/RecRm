# == Schema Information
#
# Table name: growth_entries
#
#  id                  :integer          not null, primary key
#  growth_chart_id     :integer
#  measured_at         :date
#  height_in_inches    :integer
#  weight_in_ounces    :integer
#  age                 :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  height_percentile   :integer
#  height_z_score      :integer
#  weight_percentile   :integer
#  weight_z_score      :integer
#  bmi_percentile      :integer
#  bmi_z_score         :integer
#  dietitian_note      :text
#  client_note         :text
#  energy_requirement  :string(255)
#  protein_requirement :integer
#  fluids_requirement  :integer
#

class GrowthEntry < ActiveRecord::Base
  belongs_to :growth_chart
  default_scope { order('measured_at DESC') }
  before_save :update_age
  before_destroy :check_for_appointment_review

  def height
    if (height_in_inches != nil )
      feet = self.height_in_inches / 12
      inches = self.height_in_inches % 12
      if feet <= 0
        centimeters = (inches * 2.54).round(2)
        return "#{inches} inches (#{centimeters} cm)"
      elsif inches > 0
        centimeters = (((feet * 12) + inches) * 2.54).round(2)
        return "#{feet} feet #{inches} inches (#{centimeters} cm)"
      else
        centimeters = ((feet * 12) * 2.54).round(2)
        return "#{feet} feet (#{centimeters} cm)"
      end
    else
      return "Not entered"
    end
  end

  def weight
    if (weight_in_ounces != nil )
      kilograms = (weight_in_ounces * 0.0283495).round(2)
      pounds = self.weight_in_ounces / 16
      ounces = self.weight_in_ounces % 16
      if pounds <= 0
        return "#{ounces} ounces (#{kilograms} kg)"
      elsif ounces > 0
        return "#{pounds} pounds #{ounces} ounces (#{kilograms} kg)"
      else
        return "#{pounds} pounds (#{kilograms} kg)"
      end
    else
      return "Not entered"
    end
  end

  # returns height_hash = {'feet'=> ##, 'inches' => ##}
  def height_hash
    height_hash = {}
    if self.height_in_inches
      feet = self.height_in_inches / 12
      inches = self.height_in_inches % 12
      height_hash["feet"] = feet
      height_hash["inches"] = inches
    else
      height_hash["feet"] = nil
      height_hash["inches"] = nil
    end

    return height_hash
  end

    # returns weight_hash = {'pounds'=> ##, 'ounces' => ##}
  def weight_hash
    weight_hash = {}
    if self.weight_in_ounces
      pounds = self.weight_in_ounces / 16
      ounces = self.weight_in_ounces % 16
      weight_hash["pounds"] = pounds
      weight_hash["ounces"] = ounces
    else
      weight_hash["pounds"] = nil
      weight_hash["ounces"] = nil
    end

    return weight_hash
  end

  private

  def update_age
    date_measured = self.measured_at.to_date
    self.age = Users::UserPresenter.new(growth_chart.user).age(date_measured)
  end

  def check_for_appointment_review
    if (self.height_percentile != nil) 
      errors[:messages] << "Can not delete growth entry that has been reviewd by a dietitian."
      return false
    end
  end
end
