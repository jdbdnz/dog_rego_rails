class AddFeeToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :fee, :float, null: false
  end
end
