module Magaz
  module Admin
    module BaseHelper
      def favicon
        favicon_link_tag 'logo.png'
      end

      def stylesheet
        stylesheet_link_tag "magaz/admin/admin"
      end

      def javascript
        javascript_include_tag "magaz/admin/admin"
      end

      def render_head
        render 'magaz/admin/shared/head'
      end

    end
  end
end