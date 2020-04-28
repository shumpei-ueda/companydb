class ChangeDataPhoneNumberToAdoptionPhoneNumber < ActiveRecord::Migration[6.0]
  def change
    change_column :adoption_phone_numbers, :phone_number, :string

  end
end
