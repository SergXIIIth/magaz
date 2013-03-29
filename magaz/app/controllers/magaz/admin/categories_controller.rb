# -*- encoding : utf-8 -*-
module Magaz
	module Admin
		class CategoriesController < Magaz::Admin::BaseController
			def index
				render json: Category.top_level.to_a
			end

			def create
				categoty = if params[:id]
					Category.find params[:id]
				else
					Category.new
				end

				categoty.name = params[:name]
				categoty.parent_category_id = params[:parent_category_id]
				categoty.save!

				render inline: categoty.id.to_s
			end

			def destroy
				category = Category.find params[:id]
				category.delete
				render inline: 'deleted'
			end
		end
	end
end