# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class BaseController < ApplicationController

      protect_from_forgery

      layout 'admin'

      before_filter :authenticate

      include Magaz::ContollerHelpers

    end
  end
end