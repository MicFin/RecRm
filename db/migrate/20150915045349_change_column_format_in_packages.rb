class ChangeColumnFormatInPackages < ActiveRecord::Migration

  def up
    change_column :packages, :num_full_appointments, :integer
  end

  def down
    change_column :packages, :num_full_appointments, :string
  end

end
