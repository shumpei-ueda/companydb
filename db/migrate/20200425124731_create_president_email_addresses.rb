class CreatePresidentEmailAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :president_email_addresses do |t|
      t.integer :company_president_id
      t.string :email_address
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
