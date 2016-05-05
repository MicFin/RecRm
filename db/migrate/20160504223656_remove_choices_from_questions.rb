class RemoveChoicesFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :choices, :text
  end
end
