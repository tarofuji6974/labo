class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :image_name
      t.text :profile
      t.datetime :login_date

      t.timestamps
    end
  end
end
