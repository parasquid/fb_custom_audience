class CreateWorkflows < ActiveRecord::Migration[5.0]
  def change
    create_table :workflows do |t|
      t.references :custom_audience, foreign_key: true
      t.string :mp_id

      t.timestamps
    end
  end
end
