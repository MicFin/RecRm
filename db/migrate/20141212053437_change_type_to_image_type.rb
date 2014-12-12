class ChangeTypeToImageType < ActiveRecord::Migration
 def change
    rename_column :images, :type, :image_type
  end
end
