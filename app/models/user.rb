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
      user.email = self.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
      # user.avatar = auth.info.image
    end
    # SNS認証の場合は仮登録メールを送信しない
    # user.skip_confirmation!
  end

  private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
