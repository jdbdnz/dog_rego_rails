class ChangeDogValidTillToValidUntil < ActiveRecord::Migration
  def change
    rename_column :registrations, :valid_till, :valid_until
  end
end
