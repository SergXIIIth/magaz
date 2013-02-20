module Magaz
  class Product
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name       , type: String
    field :price      , type: Money
    field :amount     , type: Integer
    field :desc       , type: String
    
  end
end
