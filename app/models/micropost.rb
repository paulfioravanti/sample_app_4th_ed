# == Schema Information
#
# Table name: microposts
#
#  id         :uuid             not null, primary key
#  content    :text
#  user_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

class Micropost < ApplicationRecord
  belongs_to :user
end
