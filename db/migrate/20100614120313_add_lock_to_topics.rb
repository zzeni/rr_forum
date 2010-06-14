class AddLockToTopics < ActiveRecord::Migration
  def self.up
    add_column :topics, :locked, :boolean
  end

  def self.down
    remove_column :topics, :locked
  end
end
