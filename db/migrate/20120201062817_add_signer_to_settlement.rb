class AddSignerToSettlement < ActiveRecord::Migration
  def self.up
    #添加审核人/审核日期 签字人/签字日期
    add_column :settlements, :auditor_id, :integer
    add_column :settlements, :audit_date, :datetime
    add_column :settlements, :signer_id, :integer
    add_column :settlements, :sign_date, :datetime
  end

  def self.down
    remove_column :settlements, :auditor_id
    remove_column :settlements, :sign_date
    remove_column :settlements, :signer_id
    remove_column :settlements, :audit_date
  end
end
