class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :token
      t.string :uid

      t.timestamps
    end
    add_index :authentications, :provider
    add_index :authentications, :uid
  end
end
