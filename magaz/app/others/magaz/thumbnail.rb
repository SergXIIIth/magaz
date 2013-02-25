module Magaz
  class Thumbnail
    def url(images, size)
      image = images.first
      if image.nil?
        "http://placehold.it/#{size}x#{size}&text=no+images"
      else
        cloudinary_url(image, size)
      end
    end

    def self.url(images, size)
      self.new.url(images, size)
    end

    private 

    def cloudinary_url(image, size)
      # http://res.cloudinary.com/makridenkov/image/upload/x_306,y_149,w_153,h_153,c_crop/w_140,h_140,c_fill/v1361798614/magaz_image_512b65d025cac25c83000003.png

      # http://res.cloudinary.com/makridenkov/image/upload/v1361798614/magaz_image_512b65d025cac25c83000003.png

      # http://res.cloudinary.com/makridenkov/image/upload/v1361507477/magaz_image_5126f48f25cac2760400002c.png

      # http://res.cloudinary.com/makridenkov/image/upload/
      #    x_355,y_410,w_300,h_200,c_crop/w_150,h_100,c_fill/v1361507477/magaz_image_5126f48f25cac2760400002c.png

      base_url = "http://res.cloudinary.com/#{Cloudinary.config.cloud_name}/image/upload/"
      transformation = "x_#{image.crop_x},y_#{image.crop_y},w_#{image.crop_w},h_#{image.crop_h},c_crop/w_#{size},h_#{size},c_fill/"

      base_url + transformation + image.data.identifier
    end

  end
end