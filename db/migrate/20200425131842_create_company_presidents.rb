class CreateCompanyPresidents < ActiveRecord::Migration[6.0]
  def change
    create_table :company_presidents do |t|
      t.integer :company_id
      t.string :president_name
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
