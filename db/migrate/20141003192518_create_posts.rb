class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content, null: false
      t.references :sub, index: true, null: false
      t.references :author, index: true, null: false

      t.timestamps
    end
  end
end
