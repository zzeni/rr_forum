# == Schema Information
# Schema version: 20100614120313
#
# Table name: topics
#
#  id         :integer         not null, primary key
#  summary    :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  locked     :boolean
#

class Topic < ActiveRecord::Base
  attr_accessible :content, :summary, :locked

  belongs_to :user
  has_many :posts, :dependent => :destroy

  validates_presence_of :content, :user_id, :summary
  validates_length_of   :summary, :maximum => 255
  validates_length_of   :content, :maximum => 4000

  default_scope :order => 'created_at DESC'

end
