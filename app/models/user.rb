class User < ApplicationRecord
  has_many :articles
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
