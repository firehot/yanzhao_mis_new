class MaterialInout < ActiveRecord::Base
  belongs_to :org
  belongs_to :warehouse
  #审核人
  belongs_to :auditor,:class_name => "User"
  #审核信息
  belongs_to :confirm

  has_many :material_inout_lines,:dependent => :destroy
  accepts_nested_attributes_for :material_inout_lines,:allow_destroy => true ,:reject_if => lambda{|attributes| attributes['material_id'].blank? or attributes['qty'].eql?('0') or attributes['qty'].blank? }
  validates_presence_of :person_name,:message => "经办人不可为空!"
  validates_presence_of :inout_date,:message => "日期不可为空"
  validates_presence_of :material_inout_lines,:message => "单据明细不可为空"
  #单据状态
  STATE_DRAFT = 'DR'    #草稿
  STATE_CONFIRM = 'CO'  #已确认
  #得到单据状态Hash
  def self.states
    {
      STATE_DRAFT => "草稿",
      STATE_CONFIRM => "已确认"
    }
  end
  #票据确认
  def confirm(user)
    if self.state == STATE_DRAFT
      self.build_confirm(:user => user)
      self.state = STATE_CONFIRM
      self.save
    end
  end

  #合计金额
  def amount
    self.material_inout_lines.sum(:line_amt)
  end

end
