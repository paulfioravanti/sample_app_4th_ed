class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts, id: :uuid do |t|
      t.text :content
      t.uuid :user_id, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
