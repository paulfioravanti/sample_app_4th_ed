class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships, id: :uuid do |t|
      t.uuid :follower_id
      t.uuid :followed_id

      t.timestamps
    end
    # NOTE: `foreign_key: true` can't be appended to `t.uuid` so adding
    # a foreign key needs to be done separately on specific columns
    add_foreign_key :relationships, :users, column: :followed_id
    add_foreign_key :relationships, :users, column: :follower_id
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
