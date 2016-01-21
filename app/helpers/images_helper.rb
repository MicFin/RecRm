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

module ImagesHelper
end
