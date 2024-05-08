module ImageUrl
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, ImageUploader
  end

  def image_path(size = :square)
    image? ? image.url(size) : "https://mapplayhouse-production-s3-bucket-mapplayhouse.s3.ap-northeast-2.amazonaws.com/default/default.png"
  end

  def upload_image_path(size = :square)
    image? ? image.url(size) : "https://mapplayhouse-production-s3-bucket-mapplayhouse.s3.ap-northeast-2.amazonaws.com/default/default.png"
  end
end
