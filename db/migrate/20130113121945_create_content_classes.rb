#coding: utf-8
#添加内容分类表
class CreateContentClasses < ActiveRecord::Migration
  def self.up
    create_table :content_classes do |t|
      t.string :name,:limit => 60,:null => false
      t.string :code,:limit => 30,:null => false
      t.boolean :hidden,:default => false,:null => false
      t.text :note

      t.timestamps
    end
    #添加 系统预置的内容分类
    [%w[公司简介 company_introduce],%w[公司文化 company_culture],%w[公司大事记 company_log],%w[公司活动 company_activity], %w[员工手册 worker_manual]].each_with_index do |c,index|
      ContentClass.create(:name => c[0],:code => c[1])
    end
  end

  def self.down
    drop_table :content_classes
  end
end
