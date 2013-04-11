module Magaz
  module Api
    
    attr_accessor :api

    def method_missing(method, *args, &block)
      if api.respond_to?(method)
        api.method_missing(method, *args, &block)
      else
        super
      end
    end

    def respond_to?(method)
      if api.respond_to?(method)
        true
      else
        super
      end
    end

  end
end