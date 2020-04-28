class AddSourceIdToCompanyFacebooks < ActiveRecord::Migration[6.0]
  def change
    add_column :company_facebooks, :source_id, :integer
  end
end
