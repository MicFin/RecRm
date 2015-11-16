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
    dob = self.growth_chart.user.date_of_birth
    date_measured = self.measured_at.to_date
    years = date_measured.year - dob.year - ((date_measured.month > dob.month || (date_measured.month == dob.month && date_measured.day >= dob.day)) ? 0 : 1)

    # for under 3 year olds return in terms of months
    if years < 3
      months = date_measured.month - dob.month
      if years == 0
        if months > 1
          final_age = months.to_s + " months old"
        else 
          final_age = months.to_s + " month old"
        end
      elsif years == 1
        if months > 1
          final_age = years.to_s + " year and " + months.to_s + " months old"
        else 
          final_age = years.to_s + " year and " + months.to_s + " month old"
        end
      else
        if months > 1
          final_age = years.to_s + " years and " + months.to_s + " months old"
        else 
          final_age = years.to_s + " years and " + months.to_s + " month old"
        end  
      end

    # for older than 3 return in terms of years and months
    else
      months = date_measured.month - dob.month
      if months == 1
        final_age = years.to_s + " years and 1 month old"
      elsif months > 1
        final_age = years.to_s + " years and " + months.to_s + " months old"
      else
        final_age = years.to_s + " years old"
      end
    end
    self.age = final_age
  end

  def check_for_appointment_review
    if (self.height_percentile != nil) 
      errors[:messages] << "Can not delete growth entry that has been reviewd by a dietitian."
      return false
    end
  end
end
