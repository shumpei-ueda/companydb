class CreateCompanyCapitals < ActiveRecord::Migration[6.0]
  def change
    create_table :company_capitals do |t|
      t.integer :company_id
      t.integer :capital , limit: 8
      t.integer :is_invalid

      t.timestamps
    end
  end
end
