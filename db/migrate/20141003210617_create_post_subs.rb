class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.references :post, index: true, null: false
      t.references :sub, index: true, null: false

      t.timestamps
    end
  end
end
