class CreateCompanyAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :company_addresses do |t|
      t.integer :company_id
      t.string :address
      t.integer :prefecture_id
      t.integer :city_id
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
