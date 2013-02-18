# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class SessionsController < BaseController

      skip_before_filter :authenticate, only: [:new, :create]

      def new
      end

      def create
        auth = request.env["omniauth.auth"]

        user = User.where(provider: auth["provider"], uid: auth["uid"]).first
        user ||= User.create_with_omniauth(auth)

        # ask user fill email if it empty
        if user.email.blank?
          session[:user_id_temp] = user.id
          redirect_to fill_email_url
        else
          session[:user_id] = user.id.to_s
          redirect_to root_url, :notice => "Signed in!"
        end
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