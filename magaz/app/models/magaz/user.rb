module Magaz
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name     , type: String
    field :email    , type: String
    field :provider , type: String
    field :uid      , type: String

    def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.name = auth['info']['name']
        user.email = auth['info']['email']
      end
    end
  end
end