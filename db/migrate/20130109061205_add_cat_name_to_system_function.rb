#coding: utf-8
class AddCatNameToSystemFunction < ActiveRecord::Migration
  def self.up
    add_column :system_functions,:cat_name,:string,:limit => 60
    add_column :system_functions,:default_action,:string,:limit => 400
    #根据func_key获取cat_name
    cat_name_map = {
      "notice" => ["通知公告",'notices_path(:active_sub_tab => 1,"search[state_is]" => "published","search[is_active_is]" => true)'],
      "rule" => ["规章制度",'rules_path(:active_sub_tab => 2,"search[state_is]" => "published","search[is_active_is]" => true)'],
      "address_book" => ["通讯录",'address_book_lines_path(:active_sub_tab => 5)'],
      "chat_message" => ["聊天室",'chat_messages_path'],
      "contract" => ["合同模版",'contracts_path(:active_sub_tab => 2,"search[date_to_gte]" => 2.months.ago.to_date)'],
      'settlement' => ["结算表","settlements_path(:active_sub_tab => 1,'search[created_at_gte]' => 2.months.ago.beginning_of_day)"],
      "settlement_lines" => ["项目费用统计",'settlement_lines_path(:active_sub_tab => 5)'],
      "durable_receipt" => ["耐用品入库单",'durable_receipts_path(:active_sub_tab => 1)'],
      "durable_shippment" => ["耐用品领用单",'durable_shippments_path(:active_sub_tab => 2)'],
      "durable_material" => ["耐用品设置",'durable_materials_path(:active_sub_tab => 3)'],
      "m_storages" => ["耐用品库存",'m_storages_path(:in_what => "durable_receipts","search[material_type_is]" => "DurableMaterial","search[qty_gt]" => 0, "search[material_is_active]" => true,:active_sub_tab => 10)'],
      "material_inout_lines" => ["耐用品-领用汇总",'material_inout_lines_path(:active_sub_tab => 11,"search[material_inout_state_eq]" => MaterialInout::STATE_CONFIRM)'],
      "scrapped_info" => ["报废单",'scrapped_infos_path(:active_sub_tab => 12)'],
      "consumer_receipt" => ["易耗品入库单",'consumer_receipts_path(:active_sub_tab => 1)'],
      "consumer_shippment" => ["易耗品领用单",'consumer_shippments_path(:active_sub_tab => 2)'],
      "consumer_m_storages" => ["易耗品库存",'m_storages_path(:in_what => "consumer_receipts","search[material_type_is]" => "ConsumerMaterial","search[qty_gt]" => 0,"search[material_is_active]" => true,:active_sub_tab => 10)'],
      "consumer_material" => ["易耗品设置",'consumer_materials_path(:active_sub_tab => 3)'],
      "carrying_bill" => ["票据-运单管理",'carrying_bills_path(:active_sub_tab => 1)'],
      "tk_info" => ["票据-运单管理",'carrying_bills_path(:active_sub_tab => 1'],
      "confirm" => ["票据-确认清单",'confirms_path(:active_sub_tab => 3,:in_what => :carrying_bills,"search[bills_type_is]" => "CarryingBill")'],
      "post_info_carrying_bill" => ["票据科-核销清单",'post_infos_path(:active_sub_tab => 6,:in_what => :carrying_bills,"search[bills_type_is]" => "CarryingBill")'],
      "inout_bill" => ["后勤-运单管理",'inout_bills_path(:active_sub_tab => 1)'],
      "clear_info" => ["后勤-运单管理",'inout_bills_path(:active_sub_tab => 1)'],
      "deliver" => ["后勤-运单管理",'inout_bills_path(:active_sub_tab => 1)'],
      "confirm" => ["后勤-确认清单",'confirms_path(:active_sub_tab => 3,:in_what => :inout_bills,"search[bills_type_is]" => "InoutBill")'],
      "post_info_inout_bill" => ["后勤-核销清单",'post_infos_path(:active_sub_tab => 8,:in_what => :inout_bills,"search[bills_type_is]" => "InoutBill")'],
      "violation" => ["违规记录",'violations_path(:active_sub_tab => 1,"search[target_org_id_eq]" => current_user.org_id)'],
      "punishment" => ["处罚记录",'punishments_path(:active_sub_tab => 2)'],
      "salary_table" => ["工资表",'salary_tables_path(:active_sub_tab => 1)'],
      "employee" => ["员工资料",'employees_path(:active_sub_tab => 2)'],
      "position" => ["职位信息",'positions_path(:active_sub_tab => 3)'],
      "budget_table" => ["预算表",'budget_tables_path(:active_sub_tab => 1)'],
      "management_fee_config" => ["预算设置",'management_fee_configs_path(:active_sub_tab => 2)'],
      "org_management_fee_config" => ["分理处预算设置",'org_management_fee_configs_path(:active_sub_tab => 3)'],
      "common_invoice" => ["票据入库",'all_invoice_receipts_path(:active_sub_tab => 1,"search[org_id_eq]" => current_user.org_id)'],
      "hand_invoice" => ["票据入库",'all_invoice_receipts_path(:active_sub_tab => 1,"search[org_id_eq]" => current_user.org_id)'],
      "computer_invoice" => ["票据入库",'all_invoice_receipts_path(:active_sub_tab => 1,"search[org_id_eq]" => current_user.org_id)'],
      "invoice_check" => ["运单盘查",'invoice_checks_path(:active_sub_tab => 12)'],
      "hand_invoice_receipt" => ["票据入库",'all_invoice_receipts_path(:active_sub_tab => 1,"search[org_id_eq]" => current_user.org_id)'],
      "computer_invoice_receipt" => ["票据入库",'all_invoice_receipts_path(:active_sub_tab => 1,"search[org_id_eq]" => current_user.org_id)'],
      "common_invoice_receipt" => ["票据入库",'all_invoice_receipts_path(:active_sub_tab => 1,"search[org_id_eq]" => current_user.org_id)'],
      "hand_invoice_shippment" => ["票据领用",'all_invoice_shippments_path(:active_sub_tab => 1) '],
      "common_invoice_shippment" => ["票据领用",'all_invoice_shippments_path(:active_sub_tab => 1)'],
      "computer_invoice_shippment" => ["票据领用",'all_invoice_shippments_path(:active_sub_tab => 1)'],
      "view_m_storage_invoice" => ["票据库存统计",'invoice_checks_path(:active_sub_tab => 12)']
    }

    SystemFunction.all.each do |sf|
      cat_name_map.keys.each do |key|
        if sf.func_key.include? key
          sf.update_attributes(:cat_name => cat_name_map[key][0],:default_action => cat_name_map[key][1])
        end
      end
    end
    SystemFunction.all.each do |sf|
      group_name = sf.group_name
      cat_name = sf.cat_name
      default_action = sf.default_action
      if cat_name.present? and group_name.present?
        sf_group = SystemFunctionGroup.find_or_create_by_group_name(group_name)
        sf_cat = SystemFunctionCat.find_or_create_by_cat_name(cat_name)
        sf.update_attributes(:system_function_cat_id => sf_cat.id)
        sf_cat.update_attributes(:default_action => default_action,:system_function_group_id => sf_group.id,:icon => ".jverticalmenu-gear-l")
      end
    end
    #票据登记中的数据需要特殊处理
    sf_cats = SystemFunctionCat.cat_name_eq(['票据入库','票据领用','运单盘查','票据库存统计']).all
    sf_group = SystemFunctionGroup.group_name_eq('手工票登记').first
    sf_group.update_attributes(:group_name => "票据登记") if sf_group
    sf_cats.each {|sfc| sfc.update_attributes(:system_function_group_id => sf_group.id)}

    sf_groups = SystemFunctionGroup.group_name_eq(['机打票登记','其他票登记','库存及票据盘查']).all
    sf_groups.each {|sfg| sfg.destroy}
    #更新system_function_group图标
    sf_group_map = {
      "公共信息" => "notice-cat-l",
      "分成结算" => "settlement-cat-l",
      "耐用品管理" => "durable-cat-l",
      "易耗品管理" => "consume-cat-l",
      "票据管理" => "carrying-bill-cat-l",
      "提货单管理" => "inout-bill-cat-l",
      "违规处罚" => "punishment-cat-l",
      "工资核算" => "salary-table-cat-l",
      "预算工具" => "budget-table-cat-l",
      "票据登记" => "invoice-cat-l"
    }
    sf_group_map.keys.each do |sfg_name|
      SystemFunctionGroup.all.each do |sfg|
        sfg.update_attributes(:icon => sf_group_map[sfg_name]) if sfg.group_name.eql?(sfg_name)
      end
    end
  end

  def self.down
    remove_column :system_functions,:cat_name
    remove_column :system_functions,:default_action
    SystemFunctionCat.destroy_all
    SystemFunctionGroup.destroy_all
  end
end
