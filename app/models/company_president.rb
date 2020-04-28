class CompanyPresident < ApplicationRecord

  belongs_to :company
  has_many :president_email_addresses
  has_many :president_phone_numbers
end
