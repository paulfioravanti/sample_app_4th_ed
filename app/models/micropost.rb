# == Schema Information
#
# Table name: microposts
#
#  id         :uuid             not null, primary key
#  content    :text
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  picture    :string
#
# Indexes
#
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_558c81314b  (user_id => users.id)
#

class Micropost < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  delegate :name,
           to: :user, prefix: true
  delegate :url,
           to: :picture, prefix: true

  mount_uploader :picture, PictureUploader

  def self.most_recent
    order(created_at: :desc)
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
