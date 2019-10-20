class AddCollumnsQuantityAndWeightToStageItems < ActiveRecord::Migration[5.2]
  def change
    add_column :stage_items, :quantity, :integer, default: 0
    add_column :stage_items, :weight, :decimal, default: 0
  end
end
