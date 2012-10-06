#coding: utf-8
#职位维护
class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.string :name,:null => false,:limit => 60
      t.boolean :is_active,:default => true
      t.decimal :salary_base,:precision => 15,:scale => 2,:default => 0
      t.decimal :position_base,:precision => 15,:scale => 2,:default => 0
      t.decimal :house_base,:precision => 15,:scale => 2,:default => 0
      t.decimal :food_base,:precision => 15,:scale => 2,:default => 0
      #以下为预留字段
      t.string :other_name_1,:limit => 60
      t.decimal :other_fee_1,:precision => 15,:scale => 2,:default => 0
      t.string :other_name_2,:limit => 60
      t.decimal :other_fee_2,:precision => 15,:scale => 2,:default => 0
      t.string :other_name_3,:limit => 60
      t.decimal :other_fee_3,:precision => 15,:scale => 2,:default => 0


      t.timestamps
    end
  end

  def self.down
    drop_table :positions
  end
end
