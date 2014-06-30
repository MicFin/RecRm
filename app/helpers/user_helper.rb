module UserHelper



	def get_user_patient_groups!
		@user_patient_groups = current_user.patient_groups
	end

	def get_user_allergens!
		@user_allergens = []
		@user_patient_groups.map do | patient_group |
			array = patient_group.allergens
			@user_allergens += array
		end
		@user_allergens = @user_allergens.uniq.sort_by{|a| a.name.downcase}
		#Rails.logger.debug("MY ALLERGENS: #{@user_allergens}")
	end

	def get_user_ingredients!
		@user_ingredients = []
		@user_allergens.map do | allergen |
			array = allergen.ingredients
			@user_ingredients += array
		end
		@user_ingredients = @user_ingredients.uniq.sort_by{|a| a.name.downcase}
		#Rails.logger.debug("MY INGREDIENTS: #{@user_ingredients}")
	end




end
