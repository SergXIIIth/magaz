# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :user, class: Magaz::User do
    name 'Sergey'
    surname 'Makridenkov'
    email 'sergey@makridenkov.com'
    uid '1'
    provider 'vkontakte'
  end
end