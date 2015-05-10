# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
FactoryGirl.create :admin
owner = FactoryGirl.create :owner
dog =  FactoryGirl.create :dog, owner: owner
FactoryGirl.create :registration, dog_id: dog.id
FactoryGirl.create :registration_payment_pending, dog_id: dog.id
FactoryGirl.create :expired_registration, dog_id: dog.id
