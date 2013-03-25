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
    sequence(:name) { |n| "Ноутбук #{n}"}
  end

  factory :product_full, class: Magaz::Product do
    sequence(:name) { |n| "Ноутбук #{n}"}
    price   Random.rand
    amount  Random.rand
    desc    Random.rand
  end

  factory :category, class: Magaz::Category do
    sequence(:name) { |n| "Электроника #{n}"}
  end
end