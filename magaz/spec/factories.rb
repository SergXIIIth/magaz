# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user, class: Magaz::User do
    name 'Sergey'
    surname 'Makridenkov'
    email 'sergey@makridenkov.com'
    uid '1'
    provider 'vkontakte'
  end

  factory :product, class: Magaz::Product do
    name 'Хлеб'
  end

  factory :product_full, class: Magaz::Product do
    name    'Хлеб'
    price   Random.rand
    amount  Random.rand
    desc    Random.rand
  end
end