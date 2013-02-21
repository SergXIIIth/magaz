module Magaz
  class ImageDecorator < Draper::Decorator
    delegate_all

    def render_image_thumbnail
      p 1
      h.render_image_thumbnail(self)
    end

  end
end