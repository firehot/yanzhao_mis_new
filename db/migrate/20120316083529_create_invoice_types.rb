class CreateInvoiceTypes < ActiveRecord::Migration
  def self.up
    #创建单据种类表
    create_table :invoice_types do |t|
      t.string :name,:null => false,:limit => 60
      t.boolean :is_active,:default => true
      t.integer :order_by,:default => 0

      t.timestamps
    end
    #给materials表添加单价字段
    add_column :materials,:unit_price,:decimal,:precision => 10,:scale => 2,:default => 0
    #给material_lines添加起止票号字段
    add_column :material_inout_lines,:from_no,:string,:default => 15
    add_column :material_inout_lines,:to_no,:string,:default => 15
    #给material_lines添加invoice_type字段
    add_column :material_inout_lines,:invoice_type_id,:integer
  end

  def self.down
    drop_table :invoice_types
    remove_column :materials,:unit_price
    remove_column :material_inout_lines,:from_no
    remove_column :material_inout_lines,:to_no
    remove_column :material_inout_lines,:invoice_type_id
  end
end
