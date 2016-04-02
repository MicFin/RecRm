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

  def posts_with_tag
    self.posts.published
  end

  def frequency
    posts_with_tag.size
  end
end
