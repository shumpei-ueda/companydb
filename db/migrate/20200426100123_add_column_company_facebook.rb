class AddColumnCompanyFacebook < ActiveRecord::Migration[6.0]
  def change
    def up
      add_column :company_facebooks, :source_id, :integer
    end

    def down
      remove_column :company_facebooks, :source_id, :integer
    end
  end
end
