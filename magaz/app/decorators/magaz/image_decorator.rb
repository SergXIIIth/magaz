module Magaz
  class ImageDecorator < Draper::Decorator
    delegate_all

    # TODO move to backend
    def render_image_thumbnail
      h.render_image_thumbnail(self)
    end
  end
end