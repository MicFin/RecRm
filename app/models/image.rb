# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  image_type     :string(255)
#  imageable_id   :integer
#  imageable_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  title          :string(255)
#  image          :string(255)
#  position       :integer          default(0)
#

class Image < ActiveRecord::Base
  # require 'file_size_validator'
  attr_accessor :image_cache
  attr_accessor :remove_image
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :imageable, polymorphic: true
  mount_uploader :image, ImageUploader
  # validates :image,
  #   :presence => true, 
  #   :file_size => { 
  #     :maximum => 0.5.megabytes.to_i 
  #   } 
  # validates_presence_of :image
  # validate :image_size_validation
  after_update :crop_image


  private
  
  # def image_size_validation
  #   errors[:image] << "should be less than 5MB" if image.size > 5.megabytes
  # end


 def crop_image
  
    image.recreate_versions! if crop_x.present?
    self.crop_x = ""
    self.crop_y = ""
    self.crop_w = ""
    self.crop_h = ""
  end

end
