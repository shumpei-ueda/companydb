class ChangeDataPhoneNumberToCompanyPhoneNumber < ActiveRecord::Migration[6.0]
  def change
    change_column :company_phone_numbers, :phone_number, :string

  end
end
