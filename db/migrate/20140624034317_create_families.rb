class CreateFamilies < ActiveRecord::Migration
  def change
    create_table "families", force: true do |t|
		t.string   "name"
		t.string   "location"
		t.integer  "head_of_family_id"
		t.datetime "created_at"
		t.datetime "updated_at"
    end
  end
end
