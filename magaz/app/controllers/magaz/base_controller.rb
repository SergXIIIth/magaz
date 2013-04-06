# -*- encoding : utf-8 -*-
module Magaz
  class BaseController < ApplicationController
    protect_from_forgery

    layout false
  end
end