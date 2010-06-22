class AddContactsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :contacts, :string, :default => ""
  end

  def self.down
    remove_column :users, :contacts
  end
end
