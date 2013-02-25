# -*- encoding : utf-8 -*-
module Magaz
  class Image
    include Mongoid::Document
    include Mongoid::Timestamps

    field :crop, type: Hash

    attr_accessible :data
    mount_uploader :data, ImageUploader

    before_destroy :remove_could_data

    def crop_json
      crop.to_json
    end

    private 

    def remove_could_data
      Cloudinary::Uploader.destroy(data.identifier)
    end
  end
end

