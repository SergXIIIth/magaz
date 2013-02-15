# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class SessionsController < ApplicationController

      layout 'admin'

      def new
      end

      def create
        auth = request.env["omniauth.auth"]

        # user = User.first(provider: auth["provider"], uid: auth["uid"]) 
        # user ||= User.create_with_omniauth(auth)

        # session[:auth_token] = user.auth_token

        redirect_to root_url, :notice => "Signed in!"
      end

      def failure
      end

    end
  end
end