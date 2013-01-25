#coding: utf-8
#职位helper
module PositionInfosHelper
  #上级机构选择
  def position_infos_for_select(org_info)
      PositionInfo.all(:conditions => ["is_active = ? and org_info_id = ? ",true,org_info.id],:order => "order_by ASC").map {|o| [o.name,o.id]}
  end
  #职位选择
  def group_position_infos_for_select(selected = nil)
    grouped_info = PositionInfo.all(:conditions => {:is_active => true},:order => "order_by ASC").group_by {|p| p.org_info}
    group_options = grouped_info.map {|k,v| [k.name,v.map {|item| [item.name,item.id]}]}
    grouped_options_for_select(group_options,selected)
  end
  #判定当前用户可否查看给定的职位信息
  def check_view_position_info_power(the_position)
    return true if current_user.is_admin
    position_infos = current_user.position_info.try(:position_infos)
    return false unless position_infos
    #自己可看自己的职位
    return true if the_position == current_user.position_info
    return true if position_infos.include? the_position
  end
end
