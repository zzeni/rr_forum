# == Schema Information
# Schema version: 20100614120313
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  topic_id   :integer
#

class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id

  belongs_to :user
  belongs_to :topic

  validates_presence_of :content, :user_id, :topic_id
  validates_length_of   :content, :maximum => 4000

  default_scope :order => 'created_at ASC'

end
