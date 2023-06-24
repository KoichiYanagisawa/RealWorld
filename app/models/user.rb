# frozen_string_literal: true

class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
