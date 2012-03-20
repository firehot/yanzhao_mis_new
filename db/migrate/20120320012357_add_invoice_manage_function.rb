#添加票据登记相关功能
class AddInvoiceManageFunction < ActiveRecord::Migration
  def self.up
    ###手工票相关功能
    SystemFunction.create :group_name => "手工票登记",:func_name => "新建手工票入库单",:func_key => "new_hand_invoice_receipt"
    SystemFunction.create :group_name => "手工票登记",:func_name => "删除手工票入库单(审核前)",:func_key => "destroy_hand_invoice_receipt"
    SystemFunction.create :group_name => "手工票登记",:func_name => "入库单审核",:func_key => "hand_invoice_receipt_audit"
    SystemFunction.create :group_name => "手工票登记",:func_name => "新建手工票领用单",:func_key => "new_hand_invoice_shippment"
    SystemFunction.create :group_name => "手工票登记",:func_name => "删除手工票领用单(审核前)",:func_key => "destroy_hand_invoice_shippment"
    SystemFunction.create :group_name => "手工票登记",:func_name => "领用单审核",:func_key => "hand_invoice_shippment_audit"
    SystemFunction.create :group_name => "手工票登记",:func_name => "设置手工票信息",:func_key => "update_hand_invoice"

    ##机打票相关功能
    SystemFunction.create :group_name => "机打票登记",:func_name => "新建机打票入库单",:func_key => "new_computer_invoice_receipt"
    SystemFunction.create :group_name => "机打票登记",:func_name => "删除机打票入库单(审核前)",:func_key => "destroy_computer_invoice_receipt"
    SystemFunction.create :group_name => "机打票登记",:func_name => "入库单审核",:func_key => "computer_invoice_receipt_audit"
    SystemFunction.create :group_name => "机打票登记",:func_name => "新建机打票领用单",:func_key => "new_computer_invoice_shippment"
    SystemFunction.create :group_name => "机打票登记",:func_name => "删除手工票领用单(审核前)",:func_key => "destroy_computer_invoice_shippment"
    SystemFunction.create :group_name => "机打票登记",:func_name => "领用单审核",:func_key => "computer_invoice_shippment_audit"

    SystemFunction.create :group_name => "机打票登记",:func_name => "设置机打票信息",:func_key => "update_computer_invoice"
    ###库存统计/运单票据盘查
    SystemFunction.create :group_name => "库存及票据盘查",:func_name => "票据库存统计",:func_key => "view_m_storage_invoice"
    SystemFunction.create :group_name => "库存及票据盘查",:func_name => "新建运单票据盘查",:func_key => "new_invoice_check"
    SystemFunction.create :group_name => "库存及票据盘查",:func_name => "修改运单票据盘查信息",:func_key => "update_invoice_check"
    SystemFunction.create :group_name => "库存及票据盘查",:func_name => "删除运单票据盘查信息",:func_key => "destroy_invoice_check"
    ##其他票据管理
    SystemFunction.create :group_name => "其他票据登记",:func_name => "新建普通票据入库单",:func_key => "new_common_invoice_receipt"
    SystemFunction.create :group_name => "其他票据登记",:func_name => "删除普通票入库单(审核前)",:func_key => "destroy_common_invoice_receipt"
    SystemFunction.create :group_name => "其他票据登记",:func_name => "入库单审核",:func_key => "common_invoice_receipt_audit"
    SystemFunction.create :group_name => "其他票据登记",:func_name => "新建普通票领用单",:func_key => "new_common_invoice_shippment"
    SystemFunction.create :group_name => "其他票据登记",:func_name => "删除普通票领用单(审核前)",:func_key => "destroy_common_invoice_shippment"
    SystemFunction.create :group_name => "其他票据登记",:func_name => "领用单审核",:func_key => "common_invoice_shippment_audit"
    ##其他票据类型管理
    SystemFunction.create :group_name => "其他票据登记",:func_name => "新建票据类型信息",:func_key => "new_common_invoice"
    SystemFunction.create :group_name => "其他票据登记",:func_name => "修改票据类型信息",:func_key => "update_common_invoice"

  end

  def self.down
    SystemFunction.destroy(:group_name_is => "其他票据登记")
    SystemFunction.destroy(:group_name_is => "库存及票据盘查")
    SystemFunction.destroy(:group_name_is => "机打票登记")
    SystemFunction.destroy(:group_name_is => "手工票登记")
  end
end
