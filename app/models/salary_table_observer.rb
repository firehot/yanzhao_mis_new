#coding: utf-8
#处理员工转正
class SalaryTableObserver < ActiveRecord::Observer
  #15号之前入职,按照1300,1400,岗位工资(转正)
  #15号之后入职,按照1300,1300,1400,岗位工资(转正)
  #当月发上月工资
  #工资审核通过时调整
  def after_update(st)
      Employee.find(:all,:conditions => {:is_active => true},:order => "order_by").each do |e|
        e.adjust_salary_base
      end
  end
end
