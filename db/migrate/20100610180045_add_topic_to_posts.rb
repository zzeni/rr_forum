class AddTopicToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :topic_id, :integer
    add_index :posts, :topic_id
  end

  def self.down
    remove_column :posts, :topic_id
  end
end
