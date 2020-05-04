class AddPrefectureIdToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :prefecture_id, :integer
  end
end
