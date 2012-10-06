module PositionsHelper
  #职位选择
  def positions_for_select
    Position.all(:conditions => {:is_active => true}).collect { |org| [org.name, org.id] }
  end
  def positions_to_json
    Position.all(:conditions => {:is_active => true}).to_json
  end
end
