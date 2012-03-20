class CreateInvoiceTypes < ActiveRecord::Migration
  def self.up
    #给materials表添加单价字段
    add_column :materials,:unit_price,:decimal,:precision => 10,:scale => 2,:default => 0
    #给material_lines添加起止票号字段
    add_column :material_inout_lines,:from_no,:string,:limit => 15
    add_column :material_inout_lines,:to_no,:string,:limit => 15
  end

  def self.down
    drop_table :invoice_types
    remove_column :materials,:unit_price
    remove_column :material_inout_lines,:from_no
    remove_column :material_inout_lines,:to_no
  end
end
