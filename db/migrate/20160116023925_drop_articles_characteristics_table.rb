class DropArticlesCharacteristicsTable < ActiveRecord::Migration
  def change
drop_table :articles_characteristics do |t|
        t.integer "article_id"
    t.integer "characteristic_id"
  end
  end
end
