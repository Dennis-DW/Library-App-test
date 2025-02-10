class User < ApplicationRecord
    has_secure_password
  
    has_many :borrowings, dependent: :destroy
    has_many :books, through: :borrowings
  
    validates :username, presence: true, uniqueness: true
    validates :email,    presence: true, uniqueness: true
  end
  