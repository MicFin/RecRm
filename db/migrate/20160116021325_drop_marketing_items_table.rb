class DropMarketingItemsTable < ActiveRecord::Migration

  def change
    drop_table :marketing_items do |t|
        t.string   :category
        t.integer  :order
        t.text     :content
        t.integer  :dietitian_id
        t.datetime :created_at
        t.datetime :updated_at
        t.integer  :marketing_itemable_id
        t.string   :marketing_itemable_type
        t.integer  :patient_group_id
    end
  end

end
