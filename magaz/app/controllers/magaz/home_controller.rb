# -*- encoding : utf-8 -*-
module Magaz
	class HomeController < Magaz::BaseController
		def index
			#render inline: Slim::Template.new() { 'h1 hhh' }.render(self)
			magaz_render 'index'
		end

		def page
			magaz_render params[:page]
		end

		private

		def magaz_render(view_name)
			view_file_path = Rails.root.join('app', 'skin', 'html', view_name + '.slim')
			view_html = File.read(view_file_path)

			view = View.new
			view.params = params

			render inline: Slim::Template.new() { view_html }.render(view)
		end
	end
end