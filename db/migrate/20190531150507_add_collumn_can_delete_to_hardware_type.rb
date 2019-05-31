class AddCollumnCanDeleteToHardwareType < ActiveRecord::Migration[5.2]
  def change
    add_column :hardware_types, :can_delete, :boolean, default: true
  end
end
