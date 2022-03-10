# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string
#
class User < ApplicationRecord
  attr_reader :password
  
  validates :session_token, presence: true
  after_initialize :ensure_session_token
  validates :email, presence: true
  validates :password_digest, presence: { message: ' can\'t be blank' }
  validates :password, length: {minimum: 6, allow_nil: true}
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end
  
  def password=(password) # wen the user input a password directly runs to this password function to make it even more secure
    @password = password # set an instance method for storing the password and not persisted in the db
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password!(password) # check if the password is the password who is in the DB level
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  # find the user by credentials
  def self.find_by_credentials(email,password)
    user =  User.find_by(:email => email)
    return nil if user.nil?
    user.is_password!(password) ? user : nil
  end

  private 

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
