module Magaz
  class Product
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name       , type: String
    field :price      , type: Money
    field :amount     , type: Integer
    field :desc       , type: String
    

    has_and_belongs_to_many :categories, 
      class_name: 'Magaz::Category', 
      inverse_of: nil

    has_and_belongs_to_many :images, 
      class_name: 'Magaz::Image', 
      inverse_of: nil, 
      dependent: :delete

    default_scope asc(:name)

  end
end
