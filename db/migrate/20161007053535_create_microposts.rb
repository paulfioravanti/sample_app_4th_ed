class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts, id: :uuid do |t|
      t.text :content
      t.uuid :user_id

      t.timestamps
    end
    # NOTE: `foreign_key: true` can't be appended to `t.uuid` so adding
    # a foreign key needs to be done separately.
    add_foreign_key :microposts, :users
    add_index :microposts, [:user_id, :created_at]
  end
end
