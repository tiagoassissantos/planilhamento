class AddCollumnCanDeleteToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :can_delete, :boolean, default: true
  end
end
