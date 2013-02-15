# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class SessionsController < ApplicationController

      layout 'admin'

      def new
      end

      def create
        auth = request.env["omniauth.auth"]

        user = User.where(provider: auth["provider"], uid: auth["uid"]).first
        user ||= User.create_with_omniauth(auth)

        cookies[:user_id] = user.id.to_s

        redirect_to root_url, :notice => "Signed in!"
      end

      def failure
      end

      def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Signed out!"
      end
      
    end
  end
end