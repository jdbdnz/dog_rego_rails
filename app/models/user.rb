class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  serialize :postal_address

  has_many :dogs, foreign_key: :owner_id
  has_many :registrations, through: :dogs

  validates_presence_of :first_name, :last_name, :postal_address, :email
  validates_uniqueness_of :email, case_sensitive: false

  scope :order_created_desc, -> (desc){ desc ? order(:created_at).reverse : order(:created_at) }
  scope :owes_fees, -> { joins(:registrations).where('registrations.paid = FALSE') }

  scope :search_query, -> (query) { 
    users = User.arel_table
    query_parts = query.split(/\W+/).map {|part| "%#{part}%" }

    where (
      users[:first_name].matches_any(query_parts)
    ).or (
      users[:last_name].matches_any(query_parts)
    ).or( 
      users[:email].matches_any(query_parts)
    ).or( 
      users[:postal_address].matches_any(query_parts)
    )
  }

  def name
    "#{first_name} #{last_name}"
  end

  def postal_address_formatted
    if postal_address.is_a? String
      # user continued without selecting a geocoded suggestion
      postal_address
    else
      begin
        postal_address['results'][0]['formatted_address']
      rescue
        nil
      end
    end
  end

  # TODO: move to concern
  def fees_owing
    registrations.unpaid.map(&:fee).sum
  end

  def fees_owing?
    fees_owing > 0
  end

  def fees_paid
    registrations.paid.map(&:fee).sum
  end

  def admin?
    true if role == "admin"
  end

end
