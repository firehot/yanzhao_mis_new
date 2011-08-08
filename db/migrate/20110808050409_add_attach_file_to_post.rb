class AddAttachFileToPost < ActiveRecord::Migration
  def self.up
    add_column :base_public_messages, :attach_file_name, :string
    add_column :base_public_messages, :attach_content_type, :string
    add_column :base_public_messages, :attach_file_size,    :integer
    add_column :base_public_messages, :attach_updated_at,   :datetime

  end

  def self.down
    remove_column :base_public_messages, :attach_file_name
    remove_column :base_public_messages, :attach_content_type
    remove_column :base_public_messages, :attach_file_size
    remove_column :base_public_messages, :attach_updated_at
  end
end
