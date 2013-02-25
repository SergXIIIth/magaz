module Magaz
  class ImageSaver
    def initialize(json)
      @json = json
      @json = ActiveSupport::JSON.decode(json) if json.is_a? String
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
    end

    def save_crop
      @json.each do |item|
        image = Image.find(item['id'])
        image.crop = item['crop']
        image.save!
      end
    end
  end
end