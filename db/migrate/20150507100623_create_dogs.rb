class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.string :breed, null: false
      t.datetime :date_of_birth, null: false
      t.timestamps null: false
    end
  end
end
