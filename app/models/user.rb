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
#  remember_digest :string
#  admin           :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token

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
            length: { minimum: 6 },
            allow_nil: true

  before_save :downcase_email

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
