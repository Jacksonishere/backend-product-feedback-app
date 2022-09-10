class User < ApplicationRecord
  before_save { 
    self.email = self.email.downcase
    self.username = self.username.downcase
  }

  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false }, 
                       length: { minimum: 3, maximum: 25}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email,    presence: true,
                       uniqueness: { case_sensitive: false }, 
                       format: { with: VALID_EMAIL_REGEX }

  validates :password, length: { minimum: 8 }
  has_secure_password

  has_many :feedbacks
end
