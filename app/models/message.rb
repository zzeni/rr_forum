# == Schema Information
# Schema version: 20100617182328
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  sender     :integer
#  recepient  :integer
#  summary    :string(255)
#  message    :text
#  read       :boolean
#  replied    :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
  attr_accessible :summary, :message, :read, :replied

  belongs_to :user,      :foreign_key => "sender",    :class_name => "User"
  belongs_to :recepient, :foreign_key => "recepient", :class_name => "User"

  validates_presence_of :sender,  :recepient, :summary, :message
  validates_length_of   :summary, :maximum => 255
  validates_length_of   :message, :maximum => 4000

  default_scope :order => 'created_at DESC'

end
