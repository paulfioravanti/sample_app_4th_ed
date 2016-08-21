# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,
            presence: true,
            length: { maximum: 50 }
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password,
            presence: true,
            length: { minimum: 6 }

  before_save :downcase_email

  has_secure_password

  def self.find_and_authenticate(credentials)
    user = find_by(email: credentials[:email].downcase)
    user&.authenticate(credentials[:password])
  end

  private

  def downcase_email
    email.downcase!
  end
end
