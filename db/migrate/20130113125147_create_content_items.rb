#coding: utf-8
#内容信息
class CreateContentItems < ActiveRecord::Migration
  def self.up
    create_table :content_items do |t|
      t.string :title,:limit => 60,:null => false
      t.datetime :published_at
      t.text :context
      t.boolean :is_active,:default => true,:null => false
      t.integer :publisher_id
      t.references :content_class,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :content_items
  end
end
