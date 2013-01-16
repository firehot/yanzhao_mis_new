class CreatePositionInfos < ActiveRecord::Migration
  def self.up
    create_table :position_infos do |t|
      t.references :org_info
      t.string :name
      t.boolean :is_active
      t.integer :parent_id
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :position_infos
  end
end
