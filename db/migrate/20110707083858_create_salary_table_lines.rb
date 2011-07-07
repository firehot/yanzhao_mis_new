class CreateSalaryTableLines < ActiveRecord::Migration
  def self.up
    create_table :salary_table_lines do |t|
      #员工
      t.references :employee,:null => false
      #出勤天数
      t.decimal :work_days,:precision => 10,:scale => 2,:default => 0
      #基本工资
      t.decimal :base_salary,:precision => 10,:scale => 2,:default => 0
      #工龄工资
      t.decimal :work_year_salary,:precision => 10,:scale => 2,:default => 0
      #岗位津贴
      t.decimal :position_salary,:precision => 10,:scale => 2,:default => 0
      #伙食补助
      t.decimal :food_salary,:precision => 10,:scale => 2,:default => 0
      #住房补贴
      t.decimal :house_salary,:precision => 10,:scale => 2,:default => 0
      #出勤奖
      t.decimal :work_days_added,:precision => 10,:scale => 2,:default => 0
      #其他补助
      t.decimal :other_added,:precision => 10,:scale => 2,:default => 0
      #应扣款项
      t.decimal :deducted_fee,:precision => 10,:scale => 2,:default => 0
      #实发工资
      t.decimal :act_salary,:precision => 10,:scale => 2,:default => 0
      #工资表主表
      t.references :salary_table

      t.timestamps
    end
  end

  def self.down
    drop_table :salary_table_lines
  end
end
