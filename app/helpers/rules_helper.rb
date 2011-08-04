module RulesHelper
  #处罚依据选择
  def rules_for_select(org)
    Rule.all(:conditions => {:is_active => true,:org_id => org.id},:order => "doc_no ASC").collect { |rule| ["#{rule.title}(#{rule.doc_no})", rule.id] }
  end
end
