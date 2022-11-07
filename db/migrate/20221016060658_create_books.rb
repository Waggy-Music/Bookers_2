class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :body
      t.integer :user_id
      t.float :score, default: 0

      t.timestamps
    end
  end
end
