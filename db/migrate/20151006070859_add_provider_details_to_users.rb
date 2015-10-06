class AddProviderDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hospitals_or_practices, :text
    add_column :users, :academic_affiliations, :text
    add_column :users, :specialty, :string
    add_column :users, :subspecialty, :string
    add_column :users, :fax, :string
    add_column :users, :terms_accepted, :boolean
  end
end
