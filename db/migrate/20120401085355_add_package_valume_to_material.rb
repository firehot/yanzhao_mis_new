class AddPackageValumeToMaterial < ActiveRecord::Migration
  def self.up
    # 添加包装系数（比如1本，分为100份）
    add_column :materials, :package_volume, :integer,:default => 1
  end

  def self.down
    remove_column :materials, :package_volume
  end
end
