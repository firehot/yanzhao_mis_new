class CreateSalaryTables < ActiveRecord::Migration
  def self.up
    create_table :salary_tables do |t|
      t.string :mth,:null => false,:limit => 6
      t.date :bill_date,:null => false
      t.string :note,:limit => 20
      t.references :user
      t.string :state,:limit => 10,:null => false,:default => "draft"

      t.timestamps
    end
  end

  def self.down
    drop_table :salary_tables
  end
end
