# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Magaz::ImageSaver do
  def json
    [{'id' => 1, crop: {'x1' => 2, 'y1' => 3, 'x2' => 4, 'y2' => 5}}]
  end

  it 'return image ids' do
    image_json = Magaz::ImageSaver.new(json)
    ids = image_json.image_ids
    ids.should == [1]
  end

  # it 'save crops' do
  #   image_json = Magaz::ImageSaver.new(json)
  #   image_json.save_crop
  # end
end
