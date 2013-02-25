# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class ProductsController < Magaz::Admin::BaseController

      def index
        @products = Product.all.decorate
      end

      def new
        @product = Product.new
        render 'edit'
      end

      def edit
        @product = Product.find(params[:id]).decorate
      end

      def save
        @product = Product.where(id: params[:id]).first || Product.new

        image_saver = ImageSaver.new(params[:image_ids])
        image_saver.save(@product.images)

        @product.name       = params[:name]
        @product.price      = params[:price]
        @product.amount     = params[:amount]
        @product.desc       = params[:desc]
        @product.image_ids  = image_saver.image_ids
        @product.save!

        redirect_to admin_products_path
      end

    end
  end
end