# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class BaseController < ApplicationController

      protect_from_forgery

      layout false

      before_filter :authenticate

      include Magaz::ContollerHelpers

      def index
        redirect_to admin_orders_path
      end
    end
  end
end