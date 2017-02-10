class CreateCustomAudiences < ActiveRecord::Migration[5.0]
  def change
    create_table :custom_audiences do |t|
      t.string :fb_id

      t.timestamps
    end
  end
end
