module Magaz
  class ProductDecorator < Draper::Decorator
    delegate_all

    def edit_path
      h.edit_admin_product_path(source.id)
    end

  end
end