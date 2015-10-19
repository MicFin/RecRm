class AddSpecsToMonologuePost < ActiveRecord::Migration
  def change
    add_column :monologue_posts, :specs, :text
  end
end
