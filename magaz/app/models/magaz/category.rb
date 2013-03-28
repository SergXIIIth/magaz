module Magaz
  class Category
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String

    def as_json(opt)
      {
        id: id,
        name: name
      }
    end
  end
end
