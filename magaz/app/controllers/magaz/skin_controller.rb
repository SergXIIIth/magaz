# -*- encoding : utf-8 -*-
module Magaz
  class SkinController < Magaz::BaseController
    def index
      #render inline: Slim::Template.new() { 'h1 hhh' }.render(self)
      render_skin 'index'
    end

    def css
      path = params[:path]
      css = Sass::Engine.new(skin_file_read("css/#{path}.sass")).render
      headers['Content-Type'] = 'text/css'
      render inline: css
    end

    def javascript
    end

    def img
      path = params[:path]
      ext = params[:ext]
      send_file skin_path("img/#{path}.#{ext}")
    end

    def page
      render_skin params[:page]
    end

  private
    def skin_path(path)
      fail "Bad path '#{path}'" unless path =~ /^[\/a-zA-Z0-9_]+\.?[a-zA-Z]*$/
      Rails.root.join('app/skin/' + path)
    end

    def skin_file_read(path)
      File.read(skin_path(path))
    end


    def render_skin(view_name)
      view_file_path = Rails.root.join('app', 'skin', 'html', view_name + '.slim')

      view_html = File.read(view_file_path)
      view_model_file = Rails.root.join('app', 'skin', 'code', view_name + '.rb')

      model = if File.exist?(view_model_file)
        create_view_model(view_model_file, view_name)
      else
        SkinApi.new(self)
      end

      render inline: Slim::Template.new() { view_html }.render(model)
    end

    def create_view_model(view_model_file, view_name)
      wrap = Module.new
      wrap.module_eval(File.read(view_model_file))
      model_class = wrap.const_get(view_name.capitalize)
      
      model_obj = model_class.new
      model_obj.api = SkinApi.new(self) if model_obj.respond_to? :api
      model_obj
    end
  end
end