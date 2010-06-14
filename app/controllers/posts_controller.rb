class PostsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :owner_or_admin, :only => [:edit, :update]
  before_filter :admin_user,     :only => :destroy

  def new
    @title = "Add new reply"
    @topic = Topic.find(params[:topic])
    @post = Post.new()
  end

  def create
    @topic = Topic.find(params[:post][:topic_id])
    @post = current_user.posts.new(params[:post])
    if @post.save
      flash[:success] = "Your post was successfully created"
      redirect_to @topic
    else
      @title = "Add new reply"
      render 'new'
    end
  end

  def edit
#     @post = Post.find(params[:id]) # already set by the owner filter
    @title = "Edit post"
    @topic = Topic.find(@post.topic_id)
  end

  def update
#     @post = Post.find(params[:id]) # already set by the owner filter
    @topic = Topic.find(@post.topic_id)
    @post.attributes = params[:post].reject { |k, v| k == :topic_id }
    if @post.changed? and @post.save
      flash[:success] = "Post updated successfully"
      redirect_to @topic
    else
      flash[:error] = "No changes were done" unless @post.changed?
      @title = "Edit topic"
      render 'edit'
    end
  end


  def destroy
    post = Post.find(params[:id])
    @topic = Topic.find(post.topic_id)
    post.destroy
    flash[:success] = "Post destroyed."
    redirect_to @topic
  end

  private

    def owner_or_admin
      @post = Post.find(params[:id])
      redirect_to(root_path) unless (current_user?(@post.user) and not @post.topic.locked?) or current_user.admin?
    end
end
