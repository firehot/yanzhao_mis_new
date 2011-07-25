class CreateViolationTable < ActiveRecord::Migration
  def self.up
    #    create_table :violations do |t|
    #      t.string :title,:limit => 60,:null => false
    #      t.integer :base_public_message_id
    #      t.string :target,:limit => 500 #违规对象,人名
    #      t.references :user #操作员
    #      t.integer :target_org_id #违规机构
    #      t.text :content #违规内容

    #      t.timestamps
    #    end
  end

  def self.down
    drop_table :violations
  end
end
