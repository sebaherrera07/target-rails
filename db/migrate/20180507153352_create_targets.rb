class CreateTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.string :topic, null: false
      t.integer :size, null: false
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false
    end
  end
end