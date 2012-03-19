class ShippmentObserver < ActiveRecord::Observer
  observe :durable_shippment,:consumer_shippment,:common_invoice_shippment,:hand_invoice_shippment,:computer_invoice_shippment
  #出货处理前,检查库存
  def before_save(shippment)
    #如果领用数量大于库存数,则返回
    if line.qty > m_storage.qty
      shippment.errors.add(:material_id,"库存数量不足")
      return false
    end
  end

  #出货处理完毕后,物品的库存
  def after_save(shippment)
    return if shippment.state == MaterialInout::STATE_DRAFT
    shippment.material_inout_lines.each do |line|
      m_storage = MStorage.warehouse_id_is(shippment.warehouse).material_id_is(line.material).first
      #更新库存
      m_storage.qty -= line.qty
      #设置库存报警
      m_storage.alert = (line.material.min_count > 0 && m_storage.qty <= line.material.min_count) ? true : false
      m_storage.save
    end
  end
end
