class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.integer :photo_id
      t.string :image_name
      t.string :contributor
      t.string :favorite_user_name

      t.timestamps
    end
  end
end
