class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics, id: false do |t|
      t.integer :category_id
      t.bigint :isbn, null: false, primary_key: true
      t.string :image_url
      t.string :url
      t.string :title
      t.string :author
      t.string :publisher
      t.text :item_caption

      t.timestamps
    end
  end
end
