#coding: utf-8
#职位helper
module PositionInfosHelper
  #上级机构选择
  def position_infos_for_select(org_info)
      PositionInfo.all(:conditions => ["is_active = ? and org_info_id = ? ",true,org_info.id],:order => "order_by ASC").map {|o| [o.name,o.id]}
  end
end
