module Magaz
  module Admin
    module ProductsHelper
      def save_product_path
        save_admin_product_path(@product.id)
      end

      # def edit_product_path
      #   edit_admin_product_path(???how to get product id)
      # end
    end
  end
end