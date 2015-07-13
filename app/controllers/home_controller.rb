class HomeController < ApplicationController
	# before_filter :check_user_logged_in!
	# include UserHelper
	# include FamiliesHelper
	# include RecipesHelper

	def index
		
		if current_user
			redirect_to user_authenticated_root_path
		elsif current_dietitian
			redirect_to dietitian_authenticated_root_path
		else
		@new_user  = User.new
		# #UserHelper
		# get_user_patient_groups!
		# get_user_allergens!
		# get_user_ingredients!

		# #FamilyHelper
		# get_family!
		# get_family_patient_groups!
		# get_family_allergens!
		# get_family_ingredients!

		# #RecipeHelper
		# get_recipe_list!("family")
		end
	end

	def discount_landing_page
		
		@new_user  = User.new
	end

	def home_page
		
		@thanks = params[:thanks]
		@new_user  = User.new

	end

	def join
		
		@new_user  = User.new
	end

	def provider3126
		
		@user  = User.new
	end

	def provider9172
		
		@user  = User.new
	end

	private

		def check_user_logged_in! 

		  if current_user 

		    true
		  else

		    authenticate_user!
		    true
		  end
		end

end

