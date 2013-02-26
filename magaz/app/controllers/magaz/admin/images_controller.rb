# -*- encoding : utf-8 -*-
module Magaz
	module Admin
		class ImagesController < Magaz::Admin::BaseController
			def create
				image = Image.new

				# :public_id => 'sample'
				# image_hash = Cloudinary::Uploader.upload(params[:image])
				# image.data = "v#{version}/#{identifier.split("/").last}"

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