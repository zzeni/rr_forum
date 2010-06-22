# == Schema Information
# Schema version: 20100617182328
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

require 'spec_helper'

describe Post do

  before(:each) do
    @user   = Factory(:user)
    @topic  = @user.topics.create!(:summary => "summary", :content => "content")
    @attr   = { :content => "value for content", :topic_id => @topic.id }
  end

  it "should create a new instance given valid attributes" do
    @user.posts.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @post = @user.posts.create(@attr)
      @post1 = Factory(:post, :user => @user, :topic_id => @topic.id, :created_at => 1.day.ago)
      @post2 = Factory(:post, :user => @user, :topic_id => @topic.id, :created_at => 1.hour.ago)
    end

    it "should have a user attribute" do
      @post.should respond_to(:user)
    end

    it "should have the right associated user" do
      @post.user_id.should == @user.id
      @post.user.should == @user
    end

    it "should destroy associated posts" do
      @user.destroy
      [@post1, @post2].each do |post|
        lambda do
          Post.find(post.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end

  describe "validations" do

    it "should require a user id" do
      Post.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.posts.build(:content => "  ").should_not be_valid
    end

    it "should reject too long content" do
      @user.posts.build(:content => "a" * 4001).should_not be_valid
    end
  end

end
