# == Schema Information
# Schema version: 20100617182328
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

require 'spec_helper'

describe Topic do
  before(:each) do
    @user = Factory(:user)
    @valid_attributes = {
      :summary => "value for summary",
      :content => "value for content"
    }
  end

  it "should create a new instance given valid attributes" do
    @user.topics.create!(@valid_attributes)
  end
end
