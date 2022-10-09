class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @deys2_ago_book = @books.created_2deys_ago
    @deys3_ago_book = @books.created_3deys_ago
    @deys4_ago_book = @books.created_4deys_ago
    @deys5_ago_book = @books.created_5deys_ago
    @deys6_ago_book = @books.created_6deys_ago
    
    
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def daily_posts
    
    user = User.find(params[:user_id])
    @books = user.books.where(created_at: params[:created_at].to_date.all_day)
    render :daily_posts_form
  end

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
