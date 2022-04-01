class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :status, null: false, default: 0
      t.integer :priority, null: false, default: 1
      t.datetime :published_at
      t.date :approved_on

      t.timestamps
    end
  end
end
