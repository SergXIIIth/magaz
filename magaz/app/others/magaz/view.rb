module Magaz
  class View

    attr_accessor :params

    def products
      Product.all.decorate
    end

    def product
      Product.find(id).decorate
    end

    def categories
      Category.all.decorate
    end

    def category
      Category.find(id).decorate
    end

    private

      def id
        params[:id]
      end

  end
end