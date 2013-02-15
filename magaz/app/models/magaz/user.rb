module Magaz
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name     , type: String
    field :email    , type: String
    field :provider , type: String
    field :uid      , type: String

    def self.create_with_omniauth
    end
  end
end
