class CreateInvoiceChecks < ActiveRecord::Migration
  def self.up
    create_table :invoice_checks do |t|
      t.date :check_date,:null => false
      t.references :org,:null => false
      t.integer :computer_balance_count,:default => 0
      t.integer :computer_receive_count,:default => 0
      t.integer :computer_used_count,:default => 0
      t.integer :computer_invalid_count,:default => 0
      t.integer :hand_balance_count,:default => 0
      t.integer :hand_receive_count,:default => 0
      t.integer :hand_used_count,:default => 0
      t.integer :hand_invalid_count,:default => 0
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :invoice_checks
  end
end
