class CreateBudgetTables < ActiveRecord::Migration
  def self.up
    create_table :budget_tables do |t|
      t.references :org,:null => false
      t.decimal :sum_carrying_fee,:precision => 15,:scale => 2,:default => 0
      t.decimal :commission_rate,:precision => 15,:scale => 3,:default => 0

      t.decimal :rent_fee,:precision => 15,:scale => 2,:default => 0

      t.decimal :salary_rate,:precision => 15,:scale => 3,:default => 0

      t.decimal :utilities_fee,:precision => 15,:scale => 2,:default => 0

      t.decimal :office_fee,:precision => 15,:scale => 2,:default => 0

      t.decimal :communication_fee,:precision => 15,:scale => 2,:default => 0

      t.decimal :profit_rate,:precision => 15,:scale => 3,:default => 0

      t.decimal :goods_loaded,:precision => 15,:scale => 2,:default => 0

      t.decimal :distance,:precision => 15,:scale => 2,:default => 0

      t.decimal :fuel_fee,:precision => 15,:scale => 2,:default => 0

      t.decimal :compensate_rate,:precision => 15,:scale => 3,:default => 0

      t.decimal :vehicle_fee,:precision => 15,:scale => 2,:default => 0


      t.timestamps
    end
  end

  def self.down
    drop_table :budget_tables
  end
end
