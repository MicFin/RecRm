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
      
	end


end
