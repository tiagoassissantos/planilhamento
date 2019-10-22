class AddColumnSheetToConstructionItem < ActiveRecord::Migration[5.2]
  def change
    add_column :construction_stages, :sheet, :text
  end
end
