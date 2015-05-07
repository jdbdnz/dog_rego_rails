class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :dog_id, null: false
      t.datetime :valid_from, null: false
      t.datetime :valid_till, null: false
      t.boolean :paid, default: false, null: false

      t.timestamps null: false
    end
  end
end
