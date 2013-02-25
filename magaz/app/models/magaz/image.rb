# -*- encoding : utf-8 -*-
module Magaz
  class Image
    include Mongoid::Document
    include Mongoid::Timestamps

    field :crop_x, type: Integer, default: 0
    field :crop_y, type: Integer, default: 0
    field :crop_w, type: Integer, default: 100
    field :crop_h, type: Integer, default: 100

    attr_accessible :data
    mount_uploader :data, ImageUploader

    before_destroy :remove_could_data

    def crop_json
      p self

      crop = {
          x1: crop_x, 
          y1: crop_y, 
          x2: crop_x + crop_w, 
          y2: crop_y + crop_h
        }

      crop.to_json
    end

    private 

    def remove_could_data
      Cloudinary::Uploader.destroy(data.identifier)
    end
  end
end

