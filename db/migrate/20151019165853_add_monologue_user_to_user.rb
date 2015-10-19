class AddMonologueUserToUser < ActiveRecord::Migration
  def change
    add_reference :users, :monologue_user, index: true
  end
end
