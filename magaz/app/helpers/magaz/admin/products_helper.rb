module Magaz
  module Admin
    module ProductsHelper
      def save_product_path
        save_admin_product_path(@product.id)
      end
    end
  end
end