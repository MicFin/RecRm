class AddPolymorphicToMarketingItem < ActiveRecord::Migration
  def change
    add_column :marketing_items, :marketing_itemable_id, :integer
    add_column :marketing_items, :marketing_itemable_type, :string
    add_index :marketing_items, [:marketing_itemable_id, :marketing_itemable_type], name: "marketing_itemable_id_index"
  end
end
