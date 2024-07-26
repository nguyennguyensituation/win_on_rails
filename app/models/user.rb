class User < ApplicationRecord
  has_secure_password
  
  validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 30}
  validates :password, presence: true, length: {minimum: 8, maximum: 30}
end
