class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :comic_id
      t.integer :user_id
      t.text :review
      t.float :rate, null: false, default: 0

      t.timestamps
    end
  end
end
