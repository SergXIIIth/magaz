# -*- encoding : utf-8 -*-
module Magaz
  module ContollerHelpers
    
    def self.included(receiver_class)
      receiver_class.class_eval do
        include InstanceMethods
        helper_method :current_user
        helper_method :current_user?
      end
    end

    module InstanceMethods
      protected

      def authenticate
        if current_user?
          true
        else
          session[:return_to] = request.path
          redirect_to(login_path)
          false
        end
      end

      def current_user
        @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
      end
      
      def current_user?
        current_user.present?
      end

      def redirect_back_or_to_custom_url(custom_url = '/')
        redirect_to(session[:return_to] || custom_url)
        session[:return_to] = nil
      end
    end

  end
end
