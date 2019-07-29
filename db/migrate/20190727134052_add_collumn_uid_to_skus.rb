class AddCollumnUidToSkus < ActiveRecord::Migration[5.2]
  def change
    enable_extension("citext")
    add_column :skus, :uid, :citext
  end
end
