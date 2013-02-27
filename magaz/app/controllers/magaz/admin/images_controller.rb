# -*- encoding : utf-8 -*-
module Magaz
	module Admin
		class ImagesController < Magaz::Admin::BaseController
			def create
				image = Image.new

				# Temp solution, since thought CarrierWave can not get widht, height
				image_hash = Cloudinary::Uploader.upload(
					params[:image],
					public_id: "image_#{image.id}",
					:width => 1024, :height => 1024, :crop => :limit
					)

				p 'hash'
				p image_hash

				image.width 	= image_hash['width']
				image.height 	= image_hash['height']
				image.set(:data, "v#{image_hash['version']}/#{image_hash['url'].split("/").last}")

				p 'data'
				p image.data

				p "raw data #{"v#{image_hash['version']}/#{image_hash['url'].split("/").last}"}"

				# Thought CarrierWave image.data = params[:image]

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