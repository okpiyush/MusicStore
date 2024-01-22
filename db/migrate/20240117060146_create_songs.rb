class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :singer
      t.string :url
      t.float :rating
      t.integer :user_id

      t.timestamps
    end
  end
end
