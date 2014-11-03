class Family < ActiveRecord::Base
  has_many :user_families
  has_many :users, through: :user_families
  belongs_to :head_of_family, :class_name => "User", :foreign_key => "head_of_family_id"

  accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true, :reject_if => :no_first_name
  accepts_nested_attributes_for :user_families, :reject_if => :all_blank, :allow_destroy => true
  ## family can not create a user without a first name, see accepted_nested_attributes_for reject_if:
  def no_first_name(attributes)
    attributes[:first_name].blank?
  end

  def all_first_names
    first_names = []
    self.users.each do |user|
      first_names << user.first_name
    end
    count = self.users.count
    if count > 2
      first_names.map! { |x| x + "," } 
      first_names[count-1].gsub!(/\,/,'')
    end
    if count > 1
      first_names.insert(-2, "and")
    end
    first_names = first_names.join(" ")
  end

  def health_groups
    family_health_groups = []
    self.users.each do |family_member|
      if family_member.health_groups.count >= 1 
        family_member.health_groups.each do |health_group|
          family_health_groups << health_group
        end
      end
    end
    return family_health_groups.uniq
  end

end
