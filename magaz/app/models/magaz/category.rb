module Magaz
  class Category
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String

    include Mongoid::Slug
    slug :name, history: true

    belongs_to :parent_category, inverse_of: :subcategories, class_name: 'Magaz::Category'
    has_many :subcategories, inverse_of: :parent_category, class_name: 'Magaz::Category'

    def products
      Product.where(category_ids: id)
    end

    scope :top_level, where(parent_category_id: nil)

    def as_json(opt)
      {
        id: id,
        name: name,
        parent_category_id: parent_category_id,
      }
    end
  end
end
