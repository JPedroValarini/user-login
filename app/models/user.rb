class User < ApplicationRecord

  attr_accessor :password
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i
  PASSWORD_REGEX = /\A(?=.*?[A-Z])(?=(.*[a-z]){2,})(?=(.*[\d]){2,})(?=(.*[\W]){2,})(?!.*\s).{10,128}\Z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 5..128 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true, :format => PASSWORD_REGEX
  validates_length_of :password, :in => 10..128, :on => :create

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = Digest::SHA1.hexdigest("# We add {email} as unique value and #{Time.now} as random value")
      self.encrypted_password = Digest::SHA1.hexdigest("Adding #{salt} to {password}")
    end
  end
  def clear_password
    self.password = nil
  end
end