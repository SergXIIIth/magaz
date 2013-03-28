module Magaz
  class ProductDecorator < Draper::Decorator
    delegate_all

    def edit_path
      h.edit_admin_product_path(source.id)
    end

    def show_path
      h.admin_product_path(source.id)
    end

    def render_image_uploader
      h.render_image_uploader(source.images.decorate)
    end

    def thumbnail_url
      Thumbnail.url(source.images, 140)
    end

    def category_ids_json
     source.category_ids.to_json
    end
  end
end