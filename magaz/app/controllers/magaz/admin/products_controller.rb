# -*- encoding : utf-8 -*-
module Magaz
  module Admin
    class ProductsController < Magaz::Admin::BaseController

      def index
        @less = true
        @posts = [
                  {title: '1', comments: [{txt: 'a'}, {txt: 'b'}]},
                  {title: '2', comments: [{txt: 'z'}, {txt: 'x'}]},
                  ]
        @nums = [1,2,3]

      end

    end
  end
end