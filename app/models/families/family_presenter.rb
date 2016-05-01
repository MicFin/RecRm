module Families
  class FamilyPresenter < SimpleDelegator

    def family_members
      family_members = []
      family_members << users << head_of_family
      family_members.flatten!  
      Users::UserPresenter.present(family_members)
    end

    # # CLASS METHODS
    def self.present(families)
      families.map { |family| Families::FamilyPresenter.new(family) }
    end

  end
end