module Magaz
  class SkinApi

    attr_accessor :params

    def products
      Product
    end

    def categories
      Category
    end

    def id
      params[:id]
    end

    def render_partial(partial_name)
      partial_file_path = Rails.root.join('app', 'skin', 'html', 'partials', partial_name + '.slim')
      partial_html = File.read(partial_file_path)

      Slim::Template.new() { partial_html }.render(Object.new).html_safe
    end
  end
end