class UsersController < ApplicationController
  protect_from_forgery
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :show, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info, :attend_index]
  before_action :set_one_month, only: :show
  
  def index
     @users = User.all#追加してみた4月12日
  
    #@q = User.ransack(params[:q])
   # @users = @q.result(distinct: true).paginate(page: params[:page])
   # @users = @users.paginate(page: params[:page])
  end
  
  def import
    # fileは自動で一時保存される
    User.import(params[:file])
    redirect_to users_url
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザ情報を更新しました"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました"
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params) 
      flash[:success] = "#{@user.name}の基本情報を更新しました。"

    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def attend_index
    #@users = User.all
    #@users = User.where(designated_work_start_time: presence, designated_work_end_time: nil)
    @users = User.where.not(designated_work_start_time: nil).where(designated_work_end_time: nil)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, :employee_number, :uid)
    end
    
    def basic_info_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, :employee_number, :uid ,:department, :basic_time, :work_time ,:designated_work_start_time, :designated_work_end_time)
    end
    
    def user_search_params
      params.fetch(:search, {}.permit(:name, :gender,  :birthday_from, :birthday_to, :prefecture_id))
    end
  
end
