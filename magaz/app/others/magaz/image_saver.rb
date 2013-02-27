module Magaz
  class ImageSaver
    def initialize(json)
      @json = json
      @json = ActiveSupport::JSON.decode(json) if json.is_a? String
      @json ||= {}
    end

    def image_ids
      @image_ids ||= @json.map{|item| item['id']}
    end

    def save(exist_images)
      save_crop()
      delete_removed_on_client(exist_images)
    end

    private

    def delete_removed_on_client(exist_images)
      exist_images.each do |img|
        unless image_ids.include?(img.id.to_s)
          img.delete
        end
      end
    end

    def save_crop
      @json.each_with_index do |item, i|
        image = Magaz::Image.find(item['id'])

        image.crop_x = item['crop']['x1']
        image.crop_y = item['crop']['y1']
        image.crop_w = item['crop']['x2'] - image.crop_x
        image.crop_h = item['crop']['y2'] - image.crop_y
        image.order = i

        image.save!
      end
    end
  end
end