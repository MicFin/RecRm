class AddPositionToImage < ActiveRecord::Migration
  def change
    add_column :images, :position, :integer, default: 0
    add_index :images, :position
  end
end
