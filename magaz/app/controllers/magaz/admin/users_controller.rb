# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class UsersController < BaseController

      skip_before_filter :authenticate, only: [:fill_email, :fill_email_post]

      def fill_email
        if session[:user_id_temp].blank?
          redirect_to login_path
        else
          @current_user_temp = User.find(session[:user_id_temp])
        end
      end

      def fill_email_post
        res = {}
        email = params[:email]

        if session[:user_id_temp].blank?
          res[:redirect] = login_path
        elsif email.blank? || /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/.match(email) == nil
          res[:error_email] = true
        else
          user = User.find(session[:user_id_temp])
          user.email    = email
          user.name     = params[:name]
          user.surname  = params[:surname]
          user.save!

          session[:user_id] = user.id

          res[:redirect] = root_path
        end

        render json: res
      end

    end
  end
end
