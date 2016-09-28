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
  before_create :create_activation_digest

  has_secure_password

  def self.authenticate(credentials)
    user = find_by(email: credentials[:email].downcase)
    user&.authenticate(credentials[:password])
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Token.generate
    update_attribute(
      :remember_digest,
      Password::Digest.generate(remember_token)
    )
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token  = Token.generate
    self.activation_digest = Password::Digest.generate(activation_token)
  end
end
