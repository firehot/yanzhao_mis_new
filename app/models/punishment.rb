class Punishment < ActiveRecord::Base
  belongs_to :violation
  belongs_to :user
  belongs_to :org
  belongs_to :rule #处罚依据
  belongs_to :target_org,:class_name => "Org"
  validates_presence_of :punish_date,:message => "处罚时间不可为空"
  validates_presence_of :rule_id,:message => "处罚依据不可为空"
  validates_presence_of :content,:message => "内容不可为空"
  validates_presence_of :handled,:message => "经手人不可为空"
  validates_numericality_of :punishment_fee,:message => "处罚金额应为数字"

  #从违规记录生成处罚记录
  def self.new_with_violation(v)
    punishment = Punishment.new
    punishment.violation = v
    punishment.title = v.title
    punishment.target = v.target
    punishment.target_org = v.target_org
    punishment.content = v.content
    punishment
  end
end
