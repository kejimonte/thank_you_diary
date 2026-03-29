class User < ApplicationRecord
  has_many :thanks, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,  :omniauthable, omniauth_providers: [ :google_oauth2, :line ]

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    if user
      user.update(provider: auth.provider, uid: auth.uid)
    else
      user = User.create(
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end
end
