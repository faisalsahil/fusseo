class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :user_id
      t.boolean :status

      t.timestamps
    end
  end
end
