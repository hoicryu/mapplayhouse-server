class StorageService
  IMAGE_EXT_WHITELIST = /.\.(png|jpeg|jpg)$/.freeze
  attr_accessor :s3_client

  def put_image(image_path, level = "public")
    return unless resizable?(image_path)

    image_name = image_path.split("/").last
    image_key = "#{SecureRandom.uuid}/#{image_name}"

    s3_client.put_object(
      bucket: Rails.application.credentials.dig(:aws).dig(:s3_bucket_name),
      body: IO.read(image_path),
      key: "#{level}/origins/#{image_key}",
      content_type: "image/#{image_name.split('.').last}"
    )

    Image.create!(key: image_key, level: level)
  end

  def delete_image
    s3_client
  end

  def get_image(key)
    # TODO: web 에서 이미지 가져올때 pre signed url 떨궈주기
  end

  private

  def initialize
    # credentials = Aws::Credentials.new(
    #   Rails.application.credentials.dig(:aws).dig(:access_key_id),
    #   Rails.application.credentials.dig(:aws).dig(:secret_key)
    # )

    # if Rails.env.development?
    #   self.s3_client = Aws::S3::Client.new(
    #     endpoint: "http://localhost:20005",
    #     credentials: credentials,
    #     force_path_style: true
    #   )
    # else
    credentials = Aws::CognitoIdentity::CognitoIdentityCredentials.new(identity_pool_id: "ap-northeast-2:63c6b602-0cee-4562-8f48-9cc8f5885609")
    @s3_client = Aws::S3::Client.new(credentials: credentials)
    # end
  end

  def resizable?(image_path)
    !image_path.split("/").last.match(IMAGE_EXT_WHITELIST).nil?
  rescue StandardError
    false
  end
end
