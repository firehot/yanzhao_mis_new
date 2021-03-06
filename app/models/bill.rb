class Bill < ActiveRecord::Base
  belongs_to :confirm
  belongs_to :post_info
  belongs_to :user
  belongs_to :from_org,:class_name => "SubCompany"
  belongs_to :to_org,:class_name => "SubCompany"
  before_save :gen_bill_date  #根据货号生成票据日期
  validates_uniqueness_of :bill_no,:scope => :type,:message => "运单编号不可重复"
  validates_uniqueness_of :goods_no,:scope => :type,:message => "运单货号不可重复"


  #单据状态常数,不包括提款票据与提货票据特有的状态
  STATE_DRAFT = 'DR'            #草案
  STATE_CONFIRM = 'CO'          #已确认
  STATE_CONFIRM_AUDIT = 'CO_AD'#已审核
  STATE_POST='PO'               #已核销
  STATE_POST_AUDIT='PO_AD'     #已审核

  #付款方式常数
  PAYTYPE_CASH = 'CA'   #现金付款
  PAYTYPE_TH ='AP'      #提货付
  PAYTYPE_HZ = 'BP'     #回执付
  PAYTYPE_KP = 'KP'     #自货款扣除
  PAYTYPE_MP = 'MP'     #月结
  def self.pay_types
    {
      PAYTYPE_CASH => '现金付',   #现金付款
      PAYTYPE_TH => '提货付'  ,   #提货付
      PAYTYPE_HZ => '回执付'  ,   #回执付
      PAYTYPE_KP => '自货款扣',     #自货款扣除
      PAYTYPE_MP => '月结'     #月结
    }
  end
  #导出选项
  def self.export_options
    {:methods => [:from_org_name,:to_org_name,:pay_type_des,:state_des,:created_date],
     :only => [:bill_no,:goods_no,:sender_name,:sender_phone,:receiver_name,:receiver_phone,
               :bill_mth,:fee,:goods_fee,:insured_fee,:goods_num,:k_hand_fee,:k_carrying_fee,
               :act_pay_fee,:storage_fee,:clear_fee,:goods_info,:note]}
  end
  def self.add_validate
    validates_presence_of :bill_no,:message => "不可为空"
    validates_presence_of :goods_no,:message => "不可为空"
    validates_uniqueness_of :bill_no, :message => "已存在"
    validates_uniqueness_of :goods_no,:message => "已存在"

    validates_presence_of :sender_name,:message => "不可为空"
    validates_presence_of :receiver_name,:message => "不可为空"
    validates_numericality_of :fee,  :message => "应为数字"
    validates_numericality_of :goods_fee,  :message => "应为数字"
    validates_numericality_of :goods_num, :only_integer => true,:greater_than => 0, :message => "应大于0"
    validates_presence_of :bill_mth,:message => "不可为空"
    validates_format_of :goods_no, :with => /(\d{6})(\w{0,1})((?:\xe4[\xb8-\xbf][\x80-\xbf]|[\xe5-\xe8][\x80-\xbf][\x80-\xbf]|\xe9[\x80-\xbd][\x80-\xbf]|\xe9\xbe[\x80-\xa5]){0,1})(\w{0,1})(\d{1,10})-(\d{1,10})/,:message => "货号格式不正确"
    #:with =>/(\d{6})((?:\xe4[\xb8-\xbf][\x80-\xbf]|[\xe5-\xe8][\x80-\xbf][\x80-\xbf]|\xe9[\x80-\xbd][\x80-\xbf]|\xe9\xbe[\x80-\xa5]){2})(\w\d{1,10})-(\d{1,10})/,
  end
  #以下定义named_scope
  named_scope :all_bills,lambda { |user_id|
    query_date_range = ConfigInfo.get_query_range(user_id)
    {:conditions => ["bills.created_at >= ? AND bills.created_at <= ?"] + query_date_range,
     :order => "bills.created_at DESC,bills.bill_mth DESC,bills.goods_no"}
  }
  #以下定义导出时需要用到的属性
  def from_org_name
    from_org.try(:name)
  end
  def to_org_name
    to_org.try(:name)
  end
  def pay_type_des
    Bill.pay_types[pay_type]
  end
  def created_date
    created_at.strftime('%Y-%m-%d')
  end
  #扣保险费
  def k_insured_fee
    k_fee = 0
    if self.pay_type == PAYTYPE_KP      #自货款扣除
      k_fee = self.insured_fee
    end
    k_fee
  end
  #根据给定的条件计算合计
  #返回一个hash数组,便于导出
  def self.calculate_sum(options ={})
    sum = [
      self.sum(:fee,options),
      self.sum(:goods_fee,options),
      self.sum(:insured_fee,options),
      self.sum(:goods_num,options),
      self.sum(:k_hand_fee,options),
      self.sum(:k_carrying_fee,options),
      self.sum(:act_pay_fee,options),
      self.sum(:storage_fee,options),
      self.sum(:clear_fee,options)
    ]
    empty_col = ["合计:"]
    6.times do |i|
      empty_col += [""]
    end
    empty_col + sum
  end
  private
  def gen_bill_date
    self.bill_date = ('20' + self.goods_no.scan(/\A\d{6}/).first).to_date
  end
end
