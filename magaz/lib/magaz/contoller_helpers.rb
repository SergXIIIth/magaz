# -*- encoding : utf-8 -*-
module Magaz
  module ContollerHelpers
    
    def self.included(receiver)
      receiver.include(InstanceMethods)
      receiver.helper_method(:iam)
      receiver.helper_method(:iam?)
    end

    module InstanceMethods
      protected

      def authenticate
        if iam?
          true
        else
          session[:return_to] = request.path
          redirect_to(login_path)
          false
        end
      end
      
      def iam
        @iam ||= User.first(auth_token: cookies[:auth_token]) if cookies[:auth_token]
      end
      
      def iam?
        iam.present?
      end

      def redirect_back_or_to_custom_url(custom_url = '/')
        redirect_to(session[:return_to] || custom_url)
        session[:return_to] = nil
      end
    end

  end
end
