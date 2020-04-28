class CreateCompanyListings < ActiveRecord::Migration[6.0]
  def change
    create_table :company_listings do |t|
      t.integer :company_id
      t.integer :listed
      t.integer :is_invalid

      t.timestamps
    end
  end
end
