CarrierWave.configure do |config|
  config.fog_provider = "fog/aws"                        # required
  config.fog_credentials = {
    provider: "AWS",                        # required
    aws_access_key_id: Rails.application.credentials.config.dig(Rails.env.production? ? :aws_access_key_id : :staging_aws_access_key_id), # required
    aws_secret_access_key: Rails.application.credentials.config.dig(Rails.env.production? ? :aws_secret_access_key : :staging_aws_secret_access_key), # required
    region: "ap-northeast-2",             # optional, defaults to 'us-east-1'
  }
  config.fog_directory = Rails.application.credentials.config.dig(Rails.env.production? ? :aws_bucket_name : :staging_aws_bucket_name)
end