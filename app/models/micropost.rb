# == Schema Information
#
# Table name: microposts
#
#  id         :uuid             not null, primary key
#  content    :text
#  user_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
end
