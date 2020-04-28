class ChangeDataPhoneNumberToPresidentPhoneNumber < ActiveRecord::Migration[6.0]
  def change
    change_column :president_phone_numbers, :phone_number, :string

  end
end
