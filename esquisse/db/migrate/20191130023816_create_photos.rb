class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :user_name
      t.string :image_name
      t.integer :stars
      t.text :comment

      t.timestamps
    end
  end
end
