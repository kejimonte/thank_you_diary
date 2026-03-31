class User < ApplicationRecord
  has_many :thanks, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,  :omniauthable, omniauth_providers: [ :google_oauth2, :line ]

  def self.from_omniauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.create(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email || "#{auth.uid}@example.com",
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end
end
