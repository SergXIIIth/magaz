# -*- encoding : utf-8 -*-
module Magaz
	module Admin
		class ImagesController < Magaz::Admin::BaseController
			def create
				image = Image.new
				image.data = params[:image]
				image.save!
				
				@image = image
				render 'magaz/admin/shared/_image_thumbnail'
			end

			def edit
				@image = Image.find(params[:id])
			end
		end
	end
end