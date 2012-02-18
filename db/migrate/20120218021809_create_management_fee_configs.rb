class CreateManagementFeeConfigs < ActiveRecord::Migration
  def self.up
    create_table :management_fee_configs do |t|
      t.decimal :commission_rate,:precision => 15,:scale => 3,:default => 0
      t.decimal :salary_rate,:precision => 15,:scale => 3,:default => 0
      t.decimal :profit_rate,:precision => 15,:scale => 3,:default => 0
      t.decimal :compensate_rate,:precision => 15,:scale => 3,:default => 0
      t.decimal :utilities_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :communication_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :vehicle_fee,:precision => 15,:scale => 2,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :management_fee_configs
  end
end
