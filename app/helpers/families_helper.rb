module FamiliesHelper

	
	def get_family!
			# returns family members array
	    @family = current_user.head_of_families.last
      @family_members = []
      @family_members << current_user 
      @family.users.each { |user| @family_members << user } unless @family.nil?
	end

	# def get_family_patient_groups!
		
	# 	@family_patient_groups = []
	# 	@family_members.map do | family_member |
	# 		array = family_member.patient_groups
	# 		@family_patient_groups += array
	# 	end
	# 	@family_patient_groups = @family_patient_groups.uniq.sort_by{|a| a.name.downcase}
	# 	#Rails.logger.debug("MY FAMILY PATIENT GROUPS: #{@patient_groups}")
	# end

	# def get_family_allergens!
	# 	@family_allergens = []
	# 	@family_patient_groups.map do | patient_group |
	# 		array = patient_group.allergens
	# 		@family_allergens += array
	# 	end
	# 	@family_allergens = @family_allergens.uniq.sort_by{|a| a.name.downcase}
	# 	#Rails.logger.debug("MY FAMILY ALLERGENS: #{@ufamily_allergens}")
	# end

	# def get_family_ingredients!
	# 	@family_ingredients = []
	# 	@family_allergens.map do | allergen |
	# 		array = allergen.ingredients
	# 		@family_ingredients += array
	# 	end
	# 	@family_ingredients = @family_ingredients.uniq.sort_by{|a| a.name.downcase}
	# 	Rails.logger.debug("MY FAMILY INGREDIENTS: #{@family_ingredients}")
	# end

end
