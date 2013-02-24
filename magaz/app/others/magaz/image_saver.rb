module Magaz
  class ImageSaver
    def initialize(json)
      @json = json
      @json = ActiveSupport::JSON.decode(json) if json.is_a? String
    end

    def image_ids
      @image_ids ||= @json.map{|item| item['id']}
    end

    def delete_removed_on_client
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