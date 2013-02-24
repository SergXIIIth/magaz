module Magaz
  class ImageJson
    def initialize(json)
      @json = json
      @json = ActiveSupport::JSON.decode(json) if json.is_a? String
    end

    def image_ids
      @json.map{|item| item['id']}
    end
  end
end