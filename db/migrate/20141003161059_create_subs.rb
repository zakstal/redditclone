class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title
      t.text :description
      t.references :moderator, index: true

      t.timestamps
    end
  end
end
