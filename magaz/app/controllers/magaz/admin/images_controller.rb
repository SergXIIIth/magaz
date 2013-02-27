# -*- encoding : utf-8 -*-
module Magaz
	module Admin
		class ImagesController < Magaz::Admin::BaseController
			def create
				# Temp solution, since thought CarrierWave can not get widht, height
				image = CloudinaryUploader.upload(Image.new, params[:image])

				# Thought CarrierWave 
				# image = Image.new
				# image.data = params[:image]

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