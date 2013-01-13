#coding: utf-8
#内容条目
class ContentItem < ActiveRecord::Base
  belongs_to :content_class
  has_many :content_item_images
end
