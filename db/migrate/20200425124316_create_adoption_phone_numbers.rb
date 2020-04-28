class CreateAdoptionPhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :adoption_phone_numbers do |t|
      t.integer :company_id
      t.integer :phone_number
      t.integer :source_id
      t.integer :is_invalid

      t.timestamps
    end
  end
end
