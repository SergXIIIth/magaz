# -*- encoding : utf-8 -*-
module Magaz
  class Image
    include Mongoid::Document
    include Mongoid::Timestamps

    attr_accessible :data
    mount_uploader :data, ImageUploader

    before_destroy :remove_could_data

    private 

    def remove_could_data
      Cloudinary::Uploader.destroy(data.identifier)
    end
  end
end
