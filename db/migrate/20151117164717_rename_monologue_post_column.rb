class RenameMonologuePostColumn < ActiveRecord::Migration
  def change
    rename_column :monologue_posts, :editorial__final_review_required, :editorial_final_review_required
  end
end
