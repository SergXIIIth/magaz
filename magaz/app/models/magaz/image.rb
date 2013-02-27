# -*- encoding : utf-8 -*-
module Magaz
  class Image
    include Mongoid::Document
    include Mongoid::Timestamps

    field :crop_x, type: Integer
    field :crop_y, type: Integer
    field :crop_w, type: Integer
    field :crop_h, type: Integer

    field :width  , type: Integer
    field :height , type: Integer

    attr_accessible :data
    mount_uploader :data, ImageUploader

    before_destroy :remove_could_data
    before_save :make_default_crop

    def crop_json
      crop = {
          x1: crop_x, 
          y1: crop_y, 
          x2: crop_x + crop_w, 
          y2: crop_y + crop_h
        }

      crop.to_json
    end

    def data_identifier
      data.identifier
    end

    private 

    def make_default_crop
      if crop_x.nil?
        size = width < height ? width : height

        self.crop_x = 0
        self.crop_y = 0
        self.crop_h = size
        self.crop_w = size
      end
    end

    def remove_could_data
      Cloudinary::Uploader.destroy(data.identifier)
    end
  end
end

