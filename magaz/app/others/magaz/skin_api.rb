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

    def render_partial(partial_name)
      partial_file_path = Rails.root.join('app', 'skin', 'html', 'partials', partial_name + '.slim')

      if File.exists?(partial_file_path)
        partial_html = File.read(partial_file_path)
        Slim::Template.new() { partial_html }.render(Object.new).html_safe
      else
        "".hrml_safe
      end
    end

    def method_missing(meth, *args, &block)
      if meth.to_s =~ /^render_partial_(.+)$/
        #run_find_by_method($1, *args, &block)
        render_partial($1)
      else
        super
      end
    end

    def respond_to?(meth)
      if meth.to_s =~ /^render_partial_.*$/
        true
      else
        super
      end
    end

  end # SkinApi

end