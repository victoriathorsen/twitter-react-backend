class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.text :image

      t.string :google_token
      t.string :google_refresh_token


      t.timestamps
    end
  end
end
