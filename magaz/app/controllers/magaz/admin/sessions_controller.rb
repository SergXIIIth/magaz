# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class SessionsController < ApplicationController

      layout 'admin'

      def create
        @auth = request.env['omniauth.auth']
      end

    end
  end
end