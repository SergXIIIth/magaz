module Magaz
  class CategoryDecorator < Draper::Decorator
    delegate_all

    decorates_association :products
  end
end