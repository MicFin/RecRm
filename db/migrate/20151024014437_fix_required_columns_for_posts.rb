class FixRequiredColumnsForPosts < ActiveRecord::Migration

  def up
    change_column_default :monologue_posts, :editorial_initial_review_required, true
  end

  def down
    change_column_default :monologue_posts, :editorial_initial_review_required, false
  end

end
