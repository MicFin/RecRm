# == Schema Information
#
# Table name: monologue_tags
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  tag_category :string(255)
#

class Monologue::Tag < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_many :taggings
  has_many :posts,through: :taggings

  def self.grouped_tags 
    # grouped ={}
    # groups = self.all.group_by{|e| [e.content_type, e.tag_category] }
    # groups.each do |group_and_category, array_of_tags| 
    #   if !grouped.key?(group_and_category[0])
    #       grouped[group_and_category[0]] = {}
    #   end
    #   grouped[group_and_category[0]][group_and_category[1]] = array_of_tags
    # end
    # return grouped 
    self.all.group_by { |e| e.content_type }.map { |k, v| { k => v.group_by { |e| e.tag_category } } }
  end
  

  def posts_with_tag
    self.posts.published
  end

  def frequency
    posts_with_tag.size
  end
end