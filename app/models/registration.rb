class Registration < ActiveRecord::Base
  
  belongs_to :dog
  delegate :owner, :name, :breed, :date_of_birth, to: :dog

  validates_presence_of :dog_id, :valid_from, :valid_till, :fee

  REGISTRATION_PERIOD_PRICES = { 3 => 25, 6 => 65, 12 => 85 }

  scope :current, -> { where 'valid_from < ? AND valid_till > ?', DateTime.current, DateTime.current }
  scope :unpaid, -> { where paid: false }
  scope :paid, -> { where paid: true }

  def current?
    Registration.current.include? self
  end

end