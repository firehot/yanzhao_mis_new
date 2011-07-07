class CreateEmployees < ActiveRecord::Migration
  def self.up
    #员工信息
    create_table :employees do |t|
      t.string :code,:limit => 20
      t.string :name,:limit => 10,:null => false
      t.string :sex,:limit => 1
      t.string :id_card,:limit => 30
      t.string :location,:limit => 60
      t.references :org
      t.string :position,:limit => 20
      t.string :entry_date
      t.boolean :is_active,:default => true
      #基本工资基数
      t.decimal :salary_base,:precision => 10,:scale => 2,:default => 0
      #工龄工资基数
      t.decimal :work_year_base,:precision => 10,:scale => 2,:default => 0
      #岗位津贴基数
      t.decimal :position_base,:precision => 10,:scale => 2,:default => 0
      #伙食补助基数
      t.decimal :food_base,:precision => 10,:scale => 2,:default => 0
      #住房补贴基数
      t.decimal :house_base,:precision => 10,:scale => 2,:default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
