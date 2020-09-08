class User < ApplicationRecord
  has_secure_password

  has_many :cars, foreign_key: :user_id

  validates_presence_of :username, :email , :password_digest
  validates_inclusion_of :admin, in: [true,false]
  validates :email , :username, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
