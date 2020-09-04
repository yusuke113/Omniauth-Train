# frozen_string_literal: true
class User < ApplicationRecord   # rubocop:disable Style/XXX
  has_many :sns_credentials, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # Omniauthを使用するためのオプション
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.avatar = auth.info.image
    end
  end
end
