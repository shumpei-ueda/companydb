class CreateCompanyFaxNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :company_fax_numbers do |t|
      t.integer :company_id
      t.integer :fax_number
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
