class Company < ApplicationRecord

  has_many :adoption_email_addresses
  has_many :adoption_phone_numbers
  has_many :company_addresses
  has_many :company_contact_forms
  has_many :company_email_addresses
  has_many :company_fax_numbers
  has_many :company_industries
  has_many :company_media_ads
  has_many :company_phone_numbers
  has_many :company_presidents
  has_many :company_sectors
  has_many :company_web_urls
  has_many :company_listings
  has_many :company_facebooks
  has_many :company_twitters
  has_many :company_capitals
  has_many :company_pr_times



  def address
    self.company_addresses.where(is_invalid: nil).last
  end

  def phone_number
    self.company_phone_numbers.where(is_invalid: nil).last
  end

  def web_url
    self.company_web_urls.where(is_invalid: nil).last
  end

  def president
    self.company_presidents.where(is_invalid: nil).last
  end

  def listing
    self.company_listings.where(is_invalid: nil).last
  end

  def facebook
    self.company_facebooks.where(is_invalid: nil).last
  end

  def twitter
    self.company_twitters.where(is_invalid: nil).last
  end

  def contact_form
    self.company_contact_forms.where(is_invalid: nil).last
  end

  def industry
    self.company_industries.where(is_invalid:nil).last
  end

  def sector
    self.company_sectors.where(is_invalid:nil).last
  end

  def adoption_phone_number
    self.adoption_phone_numbers.where(is_invalid:nil).last
  end

  def adoption_email_address
    self.adoption_email_addresses.where(is_invalid:nil).last
  end

  def fax_number
    self.company_fax_numbers.where(is_invalid:nil).last
  end


end
