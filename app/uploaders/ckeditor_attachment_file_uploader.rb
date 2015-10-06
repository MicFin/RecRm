# encoding: utf-8
class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  # include CarrierWave::ImageScience

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Rails::Helper
  # include Sprockets::Helpers::IsolatedHelper
  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # Choose what kind of storage to use for this uploader:
  # storage :file
  if Rails.env.development? || Rails.env.test?
    storage :file 
  else
    storage :aws
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/ckeditor/attachments/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    Ckeditor.attachment_file_types
  end
end
