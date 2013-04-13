module Magaz

  class SkinApi
    
    def initialize(controller)
      @params = controller.params
    end

    attr_reader :params

    def products
      Product
    end

    def categories
      Category
    end

    def id
      params[:id]
    end

    def render_partial(partial_name, model)
      partial_file_path = Rails.root.join('app', 'skin', 'html', 'partials', partial_name + '.slim')

      if File.exists?(partial_file_path)
        partial_html = File.read(partial_file_path)
        Slim::Template.new() { partial_html }.render(model).html_safe
      else
        "".hrml_safe
      end
    end

  end # SkinApi

end