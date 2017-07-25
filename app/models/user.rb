class User < ApplicationRecord
  has_secure_password
  before_create :generate_uid

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  private
  def generate_uid
    uid = loop do
      uid = Settings.user.uid.max_length.times.map{[*0..9, *"A".."Z"].sample}.join
      break uid unless User.exists? uid: uid
    end
    self.uid = uid
  end
end
