class Warehouse < ActiveRecord::Base
  validates_presence_of :name,:message => "名称不可为空"
  #获取默认的票据仓库
  DEFAULT_INVOICE_WAREHOUSE_NAME="default_invoice_warehouse_dont_delete!!"
  DEFAULT_INVOICE_WAREHOUSE_TYPE="invoice_warehouse"
  def self.default_invoice_warehouse
    self.find_or_create_by_name_and_warehouse_type(DEFAULT_INVOICE_WAREHOUSE_NAME,DEFAULT_INVOICE_WAREHOUSE_TYPE)
  end
  #after_create callback 建立仓库信息后,向storages中插入库存信息
  def after_create
    Material.all.each do |m|
      #查找是否存在对应物品的库存记录
      storages = MStorage.warehouse_id_is(self).material_id_is(m)
      if storages.blank?
        the_storage = MStorage.new(:warehouse => self,:material => m )
        the_storage.save
      end
    end
  end
end
