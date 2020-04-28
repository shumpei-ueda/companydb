class AddSourceIdToCompanyTwitters < ActiveRecord::Migration[6.0]
  def change
    add_column :company_twitters, :source_id, :integer
  end
end
