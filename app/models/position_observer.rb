#coding: utf-8
#岗位信息监听
class PositionObserver < ActiveRecord::Observer
  #岗位信息发生变化后,修改对应员工的工资信息
  def before_save(p)
    if p.changes.has_key?("salary_base") or p.changes.has_key?("position_base") or p.changes.has_key?("house_base") or p.changes.has_key?("food_base")
      Employee.update_all({:salary_base => p.salary_base,:position_base => p.position_base,:house_base => p.house_base,:food_base => p.food_base},:position_id => p.id,:is_active => true)
    end
  end
end
