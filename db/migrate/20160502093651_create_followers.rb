class CreateFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :followers do |t|
      t.integer :follower_user_id
      t.integer :user_id
      t.timestamps
    end
  end
end
