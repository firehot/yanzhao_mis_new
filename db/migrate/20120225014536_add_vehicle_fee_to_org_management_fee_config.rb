class AddVehicleFeeToOrgManagementFeeConfig < ActiveRecord::Migration
  def self.up
    add_column :org_management_fee_configs, :vehicle_fee, :decimal,:precision => 15,:scale => 2,:default =>0
    add_column :org_management_fee_configs, :other_item_name1, :string,:limit =>20
    add_column :org_management_fee_configs, :other_item_fee1, :decimal,:precision => 15,:scale => 2,:default =>0
    add_column :org_management_fee_configs, :other_item_name2, :string,:limit =>20
    add_column :org_management_fee_configs, :other_item_fee2, :decimal,:precision => 15,:scale => 2,:default =>0
    add_column :org_management_fee_configs, :other_item_name3, :string,:limit =>20
    add_column :org_management_fee_configs, :other_item_fee3, :decimal,:precision => 15,:scale => 2,:default =>0
  end

  def self.down
    remove_column :org_management_fee_configs, :other_item_fee3
    remove_column :org_management_fee_configs, :other_item_name3
    remove_column :org_management_fee_configs, :other_item_fee2
    remove_column :org_management_fee_configs, :other_item_name2
    remove_column :org_management_fee_configs, :other_item_fee1
    remove_column :org_management_fee_configs, :other_item_name1
    remove_column :org_management_fee_configs, :vehicle_fee
  end
end
