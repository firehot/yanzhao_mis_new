#coding: utf-8
#内容条目相关图片
class CreateContentItemImages < ActiveRecord::Migration
  def self.up
    create_table :content_item_images do |t|
      t.references :content_item,:null => false
      t.string :img_file_name,:limit => 200,:null => false
      t.string :img_content_type,:limit => 60
      t.integer :img_file_size
      t.datetime :img_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :content_item_images
  end
end
