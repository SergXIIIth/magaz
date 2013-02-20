module Magaz
  class Product
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name       , type: String
    field :price      , type: Integer
  end
end
