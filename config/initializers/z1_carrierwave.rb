# Next we’ll create an initializer file to set Fog’s credentials. We’ll use environment variables to store these so that we don’t have to store them in the application.
# http://railscasts.com/episodes/383-uploading-to-amazon-s3?view=asciicast
CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :aws
    config.aws_bucket = ENV['S3_BUCKET_NAME']
    config.aws_acl = :public_read
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365
      
    config.aws_credentials = {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      :region => 'us-east-1',
      # :host => 's3.example.com',             # optional, defaults to nil
      # :endpoint => 'kindrd-pics.s3-website-us-east-1.amazonaws.com' # optional, defaults to nil
    }
  end
    
end
