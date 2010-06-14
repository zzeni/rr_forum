class TopicsController < ApplicationController
  before_filter :authenticate,   :only => [:new, :create, :edit, :update, :destroy]
  before_filter :owner_or_admin, :only => [:edit, :update]
  before_filter :admin_user,     :only => :destroy

  def new
    @title = "Create new topic"
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(params[:topic])
    if @topic.save
      flash[:success] = "Your post was successfully created"
      redirect_to @topic
    else
      @title = "Create new topic"
      render 'new'
    end
  end

  def edit
#     @topic = Topic.find(params[:id]) # already set by the owner filter
    @title = "Edit topic"
  end

  def update
#     @topic = Topic.find(params[:id]) # already set by the owner filter
    @topic.attributes = params[:topic].reject { |k, v| (not current_user.admin? and k == :locked) }
    if @topic.changed? and @topic.save
      flash[:success] = "Topic updated successfully"
      redirect_to @topic
    else
      flash[:error] = "No changes were done" unless @topic.changed?
      @title = "Edit topic"
      render 'edit'
    end
  end

  def index
    @title = "All topics"
    @topics = Topic.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(:page => params[:page], :per_page => 25)
    @title = CGI.escapeHTML(@topic.summary)
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    flash[:success] = "Topic destroyed."
    redirect_to topics_path
  end

  private

    def owner_or_admin
      @topic = Topic.find(params[:id])
      redirect_to(root_path) unless (current_user?(@topic.user) and not @topic.locked?) or current_user.admin?
    end

end
