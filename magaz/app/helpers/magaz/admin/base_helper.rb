module Magaz
  module Admin
    module BaseHelper
      def favicon
        favicon_link_tag 'magaz/logo.png'
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

      def render_main_menu
        render 'magaz/admin/shared/main_menu'
      end

      def main_menu_orders
        main_menu_active 'orders'
      end

      def main_menu_products
        main_menu_active 'products'
      end

      def main_menu_pages
        main_menu_active 'pages'
      end

      def main_menu_users
        main_menu_active 'users'
      end

      private 

      def main_menu_active(name)
        controller = params[:controller]
        if controller =~ /\/#{name}/
          { :class => 'active' }
        else
          {}
        end
      end

    end
  end
end