class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  def self.from_omniauth(uid, email, provider)
    where(uid: uid, provider: provider).first_or_create do |user|
      user.email = email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end