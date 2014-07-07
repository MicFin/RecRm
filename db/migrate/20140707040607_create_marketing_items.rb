class CreateMarketingItems < ActiveRecord::Migration
  def change
    create_table :marketing_items do |t|
      t.string :category
      t.integer :order
      t.text :content
      t.belongs_to :dietitian, index: true
      
      t.timestamps
    end
  end
end
