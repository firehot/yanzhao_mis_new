#coding: utf-8
#职位helper
module PositionInfosHelper
  #上级机构选择
  def position_infos_for_select
      PositionInfo.all(:conditions => ["is_active = ?",true],:order => "order_by ASC").map {|o| [o.name,o.id]}
  end
  #判定当前用户可否查看给定的职位信息
  def check_view_position_info_power(the_position)
    return true if current_user.is_admin
    #自己可看自己的职位
    #也可查看下级职位信息
    return true if the_position == current_user.position_info
    can_view = false
    parent_position = the_position.parent
    while parent_position
      if parent_position == current_user.position_info
        can_view = true
        break
      else
        parent_position = parent_position.parent
      end
    end
    return can_view
  end
end
