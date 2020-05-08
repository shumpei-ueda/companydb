class AddIndex < ActiveRecord::Migration[6.0]
  def change
    change_column :adoption_email_addresses, :company_id, :bigint, index: true
    change_column :adoption_phone_numbers, :company_id, :bigint, index: true
    change_column :company_addresses, :company_id, :bigint, index: true
    change_column :company_capitals, :company_id, :bigint, index: true
    change_column :company_contact_forms, :company_id, :bigint, index: true
    change_column :company_email_addresses, :company_id, :bigint, index: true
    change_column :company_facebooks, :company_id, :bigint, index: true
    change_column :company_fax_numbers, :company_id, :bigint, index: true
    change_column :company_industries, :company_id, :bigint, index: true
    change_column :company_listings, :company_id, :bigint, index: true
    change_column :company_media_ads, :company_id, :bigint, index: true
    change_column :company_phone_numbers, :company_id, :bigint, index: true
    change_column :company_pr_times, :company_id, :bigint, index: true
    change_column :company_presidents, :company_id, :bigint, index: true
    change_column :company_sectors, :company_id, :bigint, index: true
    change_column :company_twitters, :company_id, :bigint, index: true
    change_column :company_web_urls, :company_id, :bigint, index: true

    add_foreign_key :adoption_email_addresses, :companies
    add_foreign_key :adoption_phone_numbers, :companies
    add_foreign_key :company_addresses, :companies
    add_foreign_key :company_capitals, :companies
    add_foreign_key :company_contact_forms, :companies
    add_foreign_key :company_email_addresses, :companies
    add_foreign_key :company_facebooks, :companies
    add_foreign_key :company_fax_numbers, :companies
    add_foreign_key :company_industries, :companies
    add_foreign_key :company_listings, :companies
    add_foreign_key :company_media_ads, :companies
    add_foreign_key :company_phone_numbers, :companies
    add_foreign_key :company_pr_times, :companies
    add_foreign_key :company_presidents, :companies
    add_foreign_key :company_sectors, :companies
    add_foreign_key :company_twitters, :companies
    add_foreign_key :company_web_urls, :companies
  end
end
