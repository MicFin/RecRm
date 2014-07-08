class CreateJoinTableArticlesCharacteristics < ActiveRecord::Migration
  def change
    create_table :articles_characteristics, id: false do |t|
      t.integer :article_id
      t.integer :characteristic_id
    end

    add_index :articles_characteristics, :article_id
    add_index :articles_characteristics, :characteristic_id

  end
end
