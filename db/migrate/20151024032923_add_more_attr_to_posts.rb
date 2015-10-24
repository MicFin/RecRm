class AddMoreAttrToPosts < ActiveRecord::Migration
  def change

    add_column :monologue_posts, :author_complete, :boolean
    add_column :monologue_posts, :author_completed_at, :datetime
    add_index :monologue_posts, :nutrition_reviewer_id
    add_index :monologue_posts, :editorial_initial_reviewer
    add_index :monologue_posts, :spec_author_id
    add_index :monologue_posts, :user_id
    add_index :monologue_posts, :editorial_final_reviewer
    add_index :monologue_posts, :culinary_reviewer_id
    remove_column :monologue_posts, :editorial_final_reviewer
    
    change_table :monologue_posts do |t|
      t.rename :editorial_reviewer_id, :editorial_final_reviewer_id
      t.rename :editorial_initial_reviewer, :editorial_initial_reviewer_id
    end
  end
end
