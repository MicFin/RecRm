# == Schema Information
#
# Table name: families
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  location          :string(255)
#  head_of_family_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Family < ActiveRecord::Base
  attr_accessor :health_groups_names
  attr_accessor :age_groups
  attr_accessor :number_of_members
  attr_accessor :family_members
  attr_accessor :children
  attr_accessor :family_names
  attr_accessor :family_member_info

  has_many :user_families
  has_many :users, through: :user_families
  belongs_to :head_of_family, :class_name => "User", :foreign_key => "head_of_family_id"

  accepts_nested_attributes_for :users, :reject_if => :all_blank, :allow_destroy => true, :reject_if => :no_first_name
  accepts_nested_attributes_for :user_families, :reject_if => :all_blank, :allow_destroy => true

  # resourcify makes it so Family can have roles attached to family instances
  resourcify

  ## family can not create a user without a first name, see accepted_nested_attributes_for reject_if:
  def no_first_name(attributes)
    attributes[:first_name].blank?
  end


  def family_member_count
    # family members plus head of family
    return self.users.count + 1
  end

  def ages
    ages_array = []
    if self.head_of_family.age != nil
      ages_array << self.head_of_family.age
    end
    if self.users.count >= 1
      self.users.each do | family_member|
        if family_member.age != nil 
          ages_array << family_member.age
        end
      end
    end
    if ages_array == []
      ages_array = nil 
    end 
    return ages_array 
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
    self.users.includes(:patient_groups).each do |family_member|
      if family_member.patient_groups.count >= 1 
        family_member.patient_groups.each do |health_group|
          family_health_groups << health_group
        end
      end
    end
    return family_health_groups.uniq
  end

end
