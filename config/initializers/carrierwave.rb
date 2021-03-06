CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],        # required
    :region                 => 'us-east-1',
    :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],        # required
  }
  config.fog_directory  = ENV['S3_BUCKET']                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end