class Registration < ActiveRecord::Base
  
  belongs_to :dog
  delegate :owner, :name, :breed, :date_of_birth, to: :dog

  validates_presence_of :dog_id, :valid_from, :valid_till, :fee

  REGISTRATION_PERIOD_PRICES = { 3 => 25, 6 => 65, 12 => 85 }

  scope :current, -> { where 'valid_from < ? AND valid_till > ?', DateTime.current, DateTime.current }
  scope :unpaid, -> { where paid: false }
  scope :paid, -> { where paid: true }
  scope :by_expiry_date, -> { order :valid_till }

  def current?
    Registration.current.include? self
  end

  def registration_length
    if valid_from && valid_till
      (valid_till.year * 12 + valid_till.month) - (valid_from.year * 12 + valid_from.month)
    elsif dog && dog.registrations.present?
      dog.registrations.last.registration_length
    else
      3
    end
  end

end