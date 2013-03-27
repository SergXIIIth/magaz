# -*- encoding : utf-8 -*-
module Magaz
	module Admin
		class CategoriesController < Magaz::Admin::BaseController
			def index
				render json: Category.all.to_a
			end

			def create
				categoty = if params[:id]
					Category.find params[:id]
				else
					Category.new
				end

				categoty.name = params[:name]
				categoty.save!

				render inline: categoty.id.to_s
			end
		end
	end
end