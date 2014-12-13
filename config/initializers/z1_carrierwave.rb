# Next we’ll create an initializer file to set Fog’s credentials. We’ll use environment variables to store these so that we don’t have to store them in the application.
# http://railscasts.com/episodes/383-uploading-to-amazon-s3?view=asciicast
CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = ENV['S3_BUCKET_NAME']
  config.aws_acl = :public_read
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365
    
  config.aws_credentials = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
    # :region => 'us-east-1'

    # :host => 's3.example.com',             # optional, defaults to nil
    # :endpoint => 'kindrd-pics.s3-website-us-east-1.amazonaws.com' # optional, defaults to nil
  #  # For testing, upload files to local `tmp` folder.
  # if Rails.env.test? || Rails.env.cucumber?
  #   config.storage           = :file
  #   config.enable_processing = false
  #   config.root              = "#{Rails.root}/tmp"
  # else
  #   config.storage = :fog
  # end

  # config.fog_host = 'https://s3-us-east-1.amazonaws.com/bucket_name'
  # config.fog_directory = ENV['S3_BUCKET_NAME']
  # config.fog_public = false
  # config.storage = :fog


end

# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',                        # required
#     :aws_access_key_id      => 'xxx',                        # required
#     :aws_secret_access_key  => 'yyy',                        # required
#     :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
#     :host                   => 's3.example.com',             # optional, defaults to nil
#     :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
#   }
#   config.fog_directory  = 'name_of_directory'                          # required
#   config.fog_public     = false                                        # optional, defaults to true
#   config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
# end