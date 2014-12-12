class Image < ActiveRecord::Base
  attr_accessor :image_cache
  attr_accessor :remove_image
  belongs_to :imageable, polymorphic: true
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  validate :image_size_validation

  private
  
  def image_size_validation
    errors[:image] << "should be less than 5MB" if image.size > 5.megabytes
  end
end
