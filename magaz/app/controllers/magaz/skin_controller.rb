# -*- encoding : utf-8 -*-
module Magaz
	class SkinController < Magaz::BaseController
		def index
			#render inline: Slim::Template.new() { 'h1 hhh' }.render(self)
			render_skin 'index'
		end

		def page
			render_skin params[:page]
		end

		private

		def render_skin(view_name)
			view_file_path = Rails.root.join('app', 'skin', 'html', view_name + '.slim')
			view_html = File.read(view_file_path)

			skin_api = SkinApi.new
			skin_api.params = params

			view_model_file = Rails.root.join('app', 'skin', 'code', view_name + '.rb')

			model = if File.exist?(view_model_file)
				wrap = Module.new
				wrap.module_eval(File.read(view_model_file))

				model_class = wrap.const_get(view_name.capitalize)
				model_class.send(:define_method, :api){ skin_api }
				model_class.new
			else
				skin_api
			end

			render inline: Slim::Template.new() { view_html }.render(model)
		end
	end
end