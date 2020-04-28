class CreateCompanyEmailAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :company_email_addresses do |t|
      t.integer :company_id
      t.string :email_address
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
