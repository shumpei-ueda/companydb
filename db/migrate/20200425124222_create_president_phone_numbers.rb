class CreatePresidentPhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :president_phone_numbers do |t|
      t.integer :company_president_id
      t.integer :phone_number
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
