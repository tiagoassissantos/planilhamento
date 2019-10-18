class CreateStageItems < ActiveRecord::Migration[5.2]
  def change
    create_table :stage_items do |t|
      t.string :name
      t.string :abbreviation
      t.belongs_to :construction_stage, index: true

      t.timestamps
    end
  end
end
