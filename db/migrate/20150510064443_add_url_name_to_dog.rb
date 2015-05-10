class AddUrlNameToDog < ActiveRecord::Migration
  def change
    add_column :dogs, :url_name, :string, null: false, default: ''
    Dog.all.map { |dog| dog.update_attribute :url_name, dog.to_param }
  end
end
