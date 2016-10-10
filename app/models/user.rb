# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  name              :string
#  email             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :microposts, dependent: :destroy
  has_many :active_relationships,
           class_name: "Relationship",
           foreign_key: :follower_id,
           dependent: :destroy

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

  def self.active
    where(activated: true)
  end

  def self.find_with_microposts(id)
    includes(:microposts).find(id)
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

  # Activates a user
  def activate
    update_attributes(activated: true, activated_at: Time.zone.now)
  end

  def create_reset_digest
    self.reset_token  = Token.generate
    update_attributes(
      reset_digest: Password::Digest.generate(reset_token),
      reset_sent_at: Time.zone.now
    )
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
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
