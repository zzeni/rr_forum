class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :logged_user,  :only => [:new, :create]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App, #{@user.name}!"
      sign_in @user
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    # @user = User.find(params[:id]) # should be commented since the before filter 'correct_user' already assigns user by the id param
    @title = "Edit user"
  end

  def update
    # @user = User.find(params[:id]) # should be commented since the before filter 'correct_user' already assigns user by the id param

    # strip trailing whitespaces
    params.values.map! {|v| v.to_s.strip!}

    if (params[:user][:password].nil? or params[:user][:password].blank?)
      # don't update the password if field was submitted blank
      params[:user].reject! { |k, v| k =~ /password/ }
    end

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated successfully"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if (user == current_user)
      flash[:error] = "You can't delete yourself!"
      redirect_to users_path
    else
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
