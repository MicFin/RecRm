class HomeController < ApplicationController
	before_filter :check_user_logged_in!
	include UserHelper
	include FamiliesHelper
	include RecipesHelper

	#home page loads list of recipes that are safe for families.  Will combine user and family helper in the future
	def index
binding.pry
		
		#UserHelper
		get_user_patient_groups!
		get_user_allergens!
		get_user_ingredients!

		#FamilyHelper
		get_family!
		get_family_patient_groups!
		get_family_allergens!
		get_family_ingredients!

		#RecipeHelper
		get_recipe_list!("family")

	end


	private

		def check_user_logged_in! 
			binding.pry
		  if current_user 
		    true
		  else
		    authenticate_user!
		  end
		end

end

