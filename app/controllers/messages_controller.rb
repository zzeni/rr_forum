class MessagesController < ApplicationController
  before_filter :authenticate
  before_filter :owner, :only => [:show, :index]
  before_filter :cant_send_to_yourself, :only => [:create]
  before_filter :valid_reply, :only => [:create]

  def new
    store_referer
    @recepient = User.find(params[:user])

    @reply_to = (params[:reply_to])? Message.find(params[:reply_to]) : nil

    if (current_user == @recepient)
      flash[:error] = "Can't send message to yourself"
      redirect_back_or root_path
    end

    @title = "Send message to " + h(@recepient.name)
    @message = Message.new
  end

  def create
#     @recepient = User.find(params[:message][:recepient]) #created through the cant_send_to_yourself filter

    @message = current_user.messages.new(params[:message])
    @message.recepient = @recepient

    if @message.save
      # @reply_to was already set by valid_reply filter
      @reply_to.toggle!(:replied) unless @reply_to.nil? or @reply_to.replied?

      flash[:success] = "Your message was send"
      redirect_back_or root_path
    else
      @title = "Send message to " + h(@recepient.name)
      render 'new'
    end
  end

  def show
    @title = "Show message"

    @message = Message.find(params[:id])
    @message.toggle!(:read) unless @message.read?

    @sender = User.find(@message.sender)
  end

  def index
  end

  private
    def owner
      @message = Message.find(params[:id])
      redirect_to(root_path) unless current_user?(@message.recepient)
    end

    def cant_send_to_yourself
      @recepient = User.find(params[:message][:recepient])

      if (@recepient.nil?)
        flash[:error] = "Can't send message to nonexisting user"
        redirect_back_or root_path
      elsif (current_user == @recepient)
        flash[:error] = "Can't send message to yourself"
        redirect_back_or root_path
      end
    end

    def valid_reply

      return unless params[:message][:reply_to]
      @reply_to = Message.find(params[:message][:reply_to])

      return if @reply_to.nil?
      @reply_to = nil if @reply_to.recepient != current_user
    end

end
