class CreateOrgManagementFeeConfigs < ActiveRecord::Migration
  def self.up
    create_table :org_management_fee_configs do |t|
      t.references :org,:null => false
      t.decimal :rent_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :office_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :distance,:precision => 15,:scale => 2,:default => 0
      t.decimal :goods_loaded,:precision => 15,:scale => 2,:default => 0
      t.decimal :fuel_fee,:precision => 15,:scale => 2,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :org_management_fee_configs
  end
end
