class AddCollumnUidToSkus < ActiveRecord::Migration[5.2]
  def change
    add_column :skus, :uid, :string
  end
end
