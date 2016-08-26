class AddPackageIdToAppointments < ActiveRecord::Migration
  def change
    add_reference :appointments, :user_package, index: true
  end
end
