module Magaz
  class Category
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String

    belongs_to :parent_category, inverse_of: :subcategories, class_name: 'Magaz::Category'
    has_many :subcategories, inverse_of: :parent_category, class_name: 'Magaz::Category'

    scope :top_level, where(parent_category_id: nil)

    def as_json(opt)
      category_json = {
        id: id,
        name: name
      }


      if subcategories.present?
        category_json[:subcategories] = 
          subcategories.map{ |category| category.as_json(opt) }
      end

      category_json
    end
  end
end
