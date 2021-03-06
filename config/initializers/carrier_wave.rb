if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      provider: 'AWS',
      region: ENV['AWS_REGION'],
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY']
    }
    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET']
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
