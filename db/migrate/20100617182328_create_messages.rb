class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :sender
      t.integer :recepient
      t.string :summary
      t.text :message
      t.boolean :read, 		:default => false
      t.boolean :replied, :default => false

      t.timestamps
    end
    add_index :messages, :sender
    add_index :messages, :recepient
  end

  def self.down
    drop_table :messages
  end
end
