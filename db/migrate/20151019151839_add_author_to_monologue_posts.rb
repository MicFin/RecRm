class AddAuthorToMonologuePosts < ActiveRecord::Migration
  def change
    add_reference :monologue_posts, :author, index: true
    add_column :monologue_posts, :call_to_action_id, :integer
  end
end
