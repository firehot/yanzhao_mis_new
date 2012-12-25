#coding: utf-8
#添加留言内容删除功能
class AddChatMessageFunction < ActiveRecord::Migration
  def self.up
    SystemFunction.create :group_name => "聊天室",:func_name => "删除留言",:func_key => "destroy_chat_message"
  end

  def self.down
  end
end
