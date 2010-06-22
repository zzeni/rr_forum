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

require 'spec_helper'

describe Message do
  before(:each) do
    @valid_attributes = {
      :from => 1,
      :to => 1,
      :subject => "value for subject",
      :body => "value for body",
      :read => false
    }
  end

  it "should create a new instance given valid attributes" do
    Message.create!(@valid_attributes)
  end
end
