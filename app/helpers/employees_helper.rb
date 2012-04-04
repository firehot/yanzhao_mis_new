module EmployeesHelper
  def sexes_for_select
    [["男",'M'],['女','F']]
  end
  def employees_for_select
    Employee.all(:conditions => {:is_active => true},:order => "code ASC").map {|employee| [employee.name,employee.id]}
  end
end
