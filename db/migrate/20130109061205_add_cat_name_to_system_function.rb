#coding: utf-8
class AddCatNameToSystemFunction < ActiveRecord::Migration
  def self.up
    add_column :system_functions,:cat_name,:string,:limit => 60
    #根据func_key获取cat_name
    cat_name_map = {
      "notice" => "通知公告",
      "rule" => "规章制度",
      "address_book" => "通讯录",
      "chat_message" => "聊天室",
      "contract" => "合同模版",
      'settlement' => "结算表",
      "settlement_lines" => "项目费用统计",
      "durable_receipt" => "耐用品入库单",
      "durable_shippment" => "耐用品领用单",
      "durable_material" => "耐用品设置",
      "m_storages" => "耐用品库存",
      "material_inout_lines" => "耐用品-领用汇总",
      "scrapped_info" => "报废单",
      "consumer_receipt" => "易耗品入库单",
      "consumer_shippment" => "易耗品领用单",
      "consumer_m_storages" => "易耗品库存",
      "consumer_material" => "易耗品设置",
      "carrying_bill" => "票据-运单管理",
      "tk_info" => "票据-运单管理",
      "confirm" => "票据-确认清单",
      "post_info_carrying_bill" => "票据科-核销清单",
      "inout_bill" => "后勤-运单管理",
      "clear_info" => "后勤-运单管理",
      "deliver" => "后勤-运单管理",
      "confirm" => "后勤-确认清单",
      "post_info_inout_bill" => "后勤-核销清单",
      "violation" => "违规记录",
      "punishment" => "处罚记录",
      "salary_table" => "工资表",
      "employee" => "员工资料",
      "position" => "职位信息",
      "budget_table" => "预算表",
      "org_management_fee_config" => "分理处预算设置",
      "management_fee_config" => "预算设置",
      "hand_invoice_receipt" => "票据入库单",
      "computer_invoice_receipt" => "票据入库单",
      "computer_invoice_receipt" => "票据入库单",
      "common_invoice_receipt" => "票据入库单",
      "hand_invoice_shippment" => "票据领用单",
      "computer_invoice_shippment" => "票据领用单",
      "common_invoice_shippment" => "票据领用单",
      "common_invoice" => "票据入库单",
      "hand_invoice" => "票据入库单",
      "computer_invoice" => "票据入库单",
      "invoice_check" => "运单盘查",
      "view_m_storage_invoice" => "票据库存统计"
    }
    SystemFunction.all.each do |sf|
      cat_name_map.keys.each do |key|
        if sf.func_key.include? key
          sf.update_attributes(:cat_name => cat_name_map[key])
        end
      end
    end
    SystemFunction.all.each do |sf|
      group_name = sf.group_name
      cat_name = sf.cat_name
      if cat_name.present? and group_name.present?
        sf_group = SystemFunctionGroup.find_or_create_by_group_name(group_name)
        sf_cat = SystemFunctionCat.find_or_create_by_cat_name(cat_name)
        sf.update_attributes(:system_function_cat_id => sf_cat.id)
        sf_cat.update_attributes(:default_action => "test",:system_function_group_id => sf_group.id,:icon => ".jverticalmenu-gear-l")
        sf_group.update_attributes(:icon => ".jverticalmenu-gear-l")
      end
    end
  end

  def self.down
    remove_column :system_functions,:cat_name
    SystemFunctionCat.destroy_all
    SystemFunctionGroup.destroy_all
  end
end
