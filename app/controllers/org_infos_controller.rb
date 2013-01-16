#coding: utf-8
#机构信息
class OrgInfosController < ApplicationController
  def index
    #获取根目录
    @root_org_info = OrgInfo.find_by_parent_id(nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @root_org_infos }
    end
  end
end
