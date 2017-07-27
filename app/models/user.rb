class User < ApplicationRecord
  has_secure_password
  before_create :generate_uid

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  class << self
    def authenticate params
      user = User.find_by email: params[:email]
      return false unless user
      user.authenticate params[:password]
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
