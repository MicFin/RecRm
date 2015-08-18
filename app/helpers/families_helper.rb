module FamiliesHelper

	
	def get_family!
			# returns family members array
	    @family = current_user.head_of_families.where(name: "Main").first
      get_family_members!
	end

	def get_family_members!
      if !@family.nil?
      	@family.children = @family.users
      	@family.family_members = []
      	@family.family_members << @family.children << current_user
      	@family.family_members.flatten!
      end
      binding.pry
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
