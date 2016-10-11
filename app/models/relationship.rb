# == Schema Information
#
# Table name: relationships
#
#  id          :uuid             not null, primary key
#  follower_id :uuid
#  followed_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_8c9a6d4759  (follower_id => users.id)
#  fk_rails_9f3075433a  (followed_id => users.id)
#

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower, presence: true
  validates :followed, presence: true
end
