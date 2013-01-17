module OrgInfosHelper
  #上级机构选择
  def org_infos_for_parent_select(cur_org_info = nil)
    if cur_org_info
      OrgInfo.all(:conditions => ["is_active = ? and id != ? ",true,cur_org_info.id],:order => "order_by ASC").map {|o| [o.name,o.id]}
    else
      OrgInfo.all(:conditions => {:is_active => true},:order => "order_by ASC").map {|o| [o.name,o.id]}
    end
  end
end
