# -*- encoding : utf-8 -*-
module Magaz
  class Image
    include Mongoid::Document
    include Mongoid::Timestamps

    field :crop_x, type: Integer
    field :crop_y, type: Integer
    field :crop_w, type: Integer
    field :crop_h, type: Integer

    attr_accessible :data
    mount_uploader :data, ImageUploader

    before_destroy :remove_could_data

    def crop_json
      if crop_x.nil?
        {
          x1: 0, 
          y1: 0, 
          x2: 100,  # TODO get image width as init for crop
          y2: 100
        }.to_json
      else
        {
          x1: crop_x, 
          y1: crop_y, 
          x2: crop_x + crop_w, 
          y2: crop_y + crop_h
        }.to_json
      end
    end

    private 

    def remove_could_data
      Cloudinary::Uploader.destroy(data.identifier)
    end
  end
end

