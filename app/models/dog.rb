class Dog < ActiveRecord::Base
  
  belongs_to :owner, class_name: "User"
  has_many :registrations

  validates_presence_of :name, :owner_id, :breed, :date_of_birth
  validates_uniqueness_of :name, scope: :owner_id, case_sensitive: false

  STATUS_NOT_REGISTERED = "Not Registered"
  STATUS_REGISTERED = "Registered"
  STATUS_PENDING_PAYMENT = "Pending Payment"

  def registration_status
    unless current_registration?
      STATUS_NOT_REGISTERED
    else
      if current_registration.paid?
        STATUS_REGISTERED
      else
        STATUS_PENDING_PAYMENT
      end
    end
  end

  def age
    Date.current.year - self.date_of_birth.year
  end

  def current_registration
    registrations.current.first
  end

  def suggested_registration_length
    if registrations.present?
      registrations.last.registration_length
    else
      Registration::REGISTRATION_PERIOD_PRICES.first[0]
    end
  end

  def current_registration?
    current_registration.present?
  end

  def fees_owing
    registrations.unpaid.map(&:fee).sum
  end

  def registered_until
    registrations.by_expiry_date.last.valid_until if registrations.present? 
  end

  def new_registration_valid_from
    registered_until || Date.current
  end
  
  def to_param
    name.downcase
  end

end
