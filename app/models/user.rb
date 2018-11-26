class User < ApplicationRecord
  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email
  has_secure_password
end
