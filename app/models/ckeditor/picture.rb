class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, :mount_on => :data_file_name
  validates :data_file_size, file_size: { less_than: 200.kilobytes }

  def url_content
    url(:content)
  end
end
