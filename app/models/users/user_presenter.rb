module Users
  class UserPresenter < SimpleDelegator

    def age(at_date = nil)

      # if a date of birth is on file
      if date_of_birth != nil 

        at_date ||= Date.current
        
        # has person had their birthday yet this year
        had_birthday = ((at_date.month > date_of_birth.month || (at_date.month == date_of_birth.month && at_date.day >= date_of_birth.day)) ? true : false) 

        # if yes then subtract this year from birthday year, if not then also subtract 1 
        years = at_date.year - date_of_birth.year - (had_birthday ? 0 : 1)

        # get the number of calendar month difference from birthdya calendar month and at_date's calendar month
        months = had_birthday ? at_date.month - date_of_birth.month : 12 - (at_date.month - date_of_birth.month)

        # for under 1 year olds
        if years == 0
          age_text = months > 1 ? months.to_s + " months old" : months.to_s + " month old"  
        
        # for 1 year olds
        elsif years == 1
          age_text = months > 1 ? years.to_s + " year and " + months.to_s + " months old" : years.to_s + " year and " + months.to_s + " month old" 
        
        # for older than 1
        else
          age_text = months > 1 ? years.to_s + " years and " + months.to_s + " months old" : years.to_s + " years and " + months.to_s + " month old"
        end
        return age_text + " (" + date_of_birth.strftime("%-m/%-d/%y") + ")"
      else
        return "No Date of Birth"
      end
    end

    def full_name
      "#{first_name} #{last_name}" 
    end


    def height
      if (height_inches != nil )
        feet = height_inches / 12
        inches = height_inches % 12
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
      if (weight_ounces != nil )
        kilograms = (weight_ounces * 0.0283495).round(2)
        pounds = weight_ounces / 16
        ounces = weight_ounces % 16
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

    def previous_appointments_patient_focus
      # user.patient_focus gets all appointments where user is patient_Focus
      Appointments::AppointmentPresenter.present(patient_focus.complete)
    end

    def family_id
      family = families.first || head_of_families.first
      family.id 
    end

    # # CLASS METHODS
    def self.present(users)
      users.map { |user| Users::UserPresenter.new(user) }
    end

    # def head_of_families
    #   Families::FamilyPresenter.present(head_of_families)
    # end

    # # # CLASS METHODS
    # def self.present(users)
    #   users.map { |user| Users::UserPresenter.new(user) }
    # end
  end
end