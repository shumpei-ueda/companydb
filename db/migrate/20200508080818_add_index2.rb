class AddIndex2 < ActiveRecord::Migration[6.0]
  def change
    add_index :adoption_email_addresses, :company_id
    add_index :adoption_phone_numbers, :company_id
    add_index :company_addresses, :company_id
    add_index :company_capitals, :company_id
    add_index :company_contact_forms, :company_id
    add_index :company_email_addresses, :company_id
    add_index :company_facebooks, :company_id
    add_index :company_fax_numbers, :company_id
    add_index :company_industries, :company_id
    add_index :company_listings, :company_id
    add_index :company_media_ads, :company_id
    add_index :company_phone_numbers, :company_id
    add_index :company_pr_times, :company_id
    add_index :company_presidents, :company_id
    add_index :company_sectors, :company_id
    add_index :company_twitters, :company_id
    add_index :company_web_urls, :company_id
  end
end
