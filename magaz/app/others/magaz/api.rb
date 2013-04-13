module Magaz
  module Api
    
    attr_accessor :api

    def method_missing(method, *args, &block)
      if method.to_s =~ /^render_partial_(.+)$/
        #run_find_by_method($1, *args, &block)
        api.render_partial($1, self)
      else
        super
      end
    end

    def respond_to?(method)
      if method.to_s =~ /^render_partial_.*$/
        true
      else
        super
      end
    end

  end
end