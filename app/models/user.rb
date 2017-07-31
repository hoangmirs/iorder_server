class User < ApplicationRecord
  has_secure_password
  before_create :generate_uid

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  enum provider: [:facebook, :google]

  class << self
    def authenticate params
      user = User.find_by email: params[:email]
      return false unless user
      user.authenticate params[:password]
    end

    def authenticate_from_sns email: nil, name: nil, provider: nil, uid: nil
      where(provider: provider, uid: uid).first_or_create do |user|
        user.email = email
        user.name = name
        user.password = Devise.friendly_token[0, 20]
        user.provider = provider
        user.uid = uid
      end
    end
  end

  private
  def generate_uid
    uid = loop do
      uid = Settings.user.uid.max_length.times.map{[*0..9, *"A".."Z"].sample}.join
      break uid unless User.exists? uid: uid
    end
    self.uid = uid
  end
end
