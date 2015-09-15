class ChangeColumnFormatInPackages < ActiveRecord::Migration

  def up
    change_column :packages, :num_full_appointments, 'integer USING CAST("num_full_appointments" AS integer)'
  end

  def down
    change_column :packages, :num_full_appointments, :string
  end

end
