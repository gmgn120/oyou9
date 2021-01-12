class UsersController < ApplicationController
  
  before_action :ensure_correct_user, only: [:update]
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @currentUserUserRoom = UserRoom.where(user_id: current_user.id)
    @userUserRoom = UserRoom.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserUserRoom.each do |cu|
        @userUserRoom.each do |u|
          if cu.room_id == u.room_id then
            @isRoom =true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
