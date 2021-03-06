module Magaz
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name       , type: String
    field :surname    , type: String
    field :email      , type: String
    field :avatar_url , type: String

    field :provider , type: String
    field :uid      , type: String

    field :omni_auth_raw        , type: Hash

    def fullname
      "#{name} #{surname}"
    end

    def self.create_with_omniauth(auth)
      create! do |user|
        user.provider   = auth['provider']
        user.uid        = auth['uid']

        user.name       = auth['info']['first_name']
        user.surname    = auth['info']['last_name']

        if user.name.blank?
          name, surname = auth['info']['name'].split(' ')
          user.name     = name
          user.surname  = surname
        end

        user.avatar_url = auth['info']['image']
        user.email      = auth['info']['email']

        user.omni_auth_raw = auth['extra']['raw']
      end
    end
  end
end
