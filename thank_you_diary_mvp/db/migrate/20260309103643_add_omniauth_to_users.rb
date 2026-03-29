class AddOmniauthToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    user.email ||= "#{auth.uid}@line.com"
    user.password ||= Devise.friendly_token[0, 20]
    user.nickname ||= auth.info.name

    user.save!
    user
  end
end
