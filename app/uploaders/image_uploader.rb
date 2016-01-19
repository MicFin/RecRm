# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # # storage :fog
  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Rails::Helper
  # include Sprockets::Helpers::IsolatedHelper
  include CarrierWave::MimeTypes

  if Rails.env.development? || Rails.env.test?
    storage :file 
  else
    storage :aws
  end
  
# We’ve already set ImageUploader to use Fog for storage but it’s recommended that we add another couple of lines to this file to include the MimeTypes module and to process the image through set_content_type. This will set the MIME type for the image in case it’s incorrect.

  process :set_content_type
  after :remove, :clear_uploader
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def clear_uploader
    @file = @filename = @original_filename = @cache_id = @version = @storage = nil
    model.send(:write_attribute, mounted_as, nil)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

# Create different versions of your uploaded files:
  version :large do
    process :crop
    resize_to_limit(600, 600)
  end

  version :thumb do
    process :crop
    process :resize_to_limit => [200, 200]
  end
    
  version :icon do
    process :crop
    process :resize_to_limit => [100, 100]
  end

  version :small_icon do
    process :crop
    process :resize_to_limit => [50, 50]
  end

  def crop
    if model.crop_x.present?
      resize_to_limit(600, 600)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
      end
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end
  def extension_white_list
    if model.image_type == "Avatar"
      %w(jpg jpeg gif png)
    elsif model.image_type == "Ingredient"
      %w(pdf doc docx xls xlsx)
    elsif model.image_type == "Music"
      %w(mp3 wav wma ogg)
    end
  end



  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
