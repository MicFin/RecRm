class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :content
      t.belongs_to :dietitian, index: true
      t.string :title

      t.timestamps
    end
  end
end
