require 'bcrypt'

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true

  after_initialize :ensure_session_token

  has_many :subs,
  foreign_key: :moderator_id,
  inverse_of: :moderator

  has_many :posts,
  foreign_key: :author_id,
  inverse_of: :author

  has_many :comments,
  foreign_key: :author_id

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(credentials = {})
    user = User.find_by_email(credentials[:email])
    return nil if user.nil?
    user.is_password?(credentials[:password]) ? user : nil
  end

  def password=(password)
    return unless password.present?
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
