# encoding: utf-8
module Magaz
  class CloudinaryUploader
    def self.upload(image, file)
      image_hash = Cloudinary::Uploader.upload(
        file,
        public_id: "image_#{image.id}",
        :width => 1024, :height => 1024, :crop => :limit
        )

      image.width     = image_hash['width']
      image.height    = image_hash['height']
      image.set(:data, "v#{image_hash['version']}/#{image_hash['url'].split("/").last}")
      image
    end
  end
end