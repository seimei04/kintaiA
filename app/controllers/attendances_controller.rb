class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: :edit_one_month
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください"
  
  def update
    
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
  
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do   #トランザクション処理
      attendances_params.each do |id, item| #繰り返し
        attendance = Attendance.find(id)  #Attenndanceテーブルのidを代入
        if item[:started_at].present? && item[:finished_at].blank? 
          item[:finished_at] = item[:started_at]
          item[:started_at] = nil
        end
         attendance.update_attributes!(item) #複数同時更新&バリデーション
      end
    end
        flash[:success] = "１ヶ月分の勤怠情報を更新しました"
        redirect_to user_url(date: params[:date]) #showに飛ぶ
    
  rescue ActiveRecord::RecordInvalid
         flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました！"
         redirect_to attendances_edit_one_month_user_url(date: params[:date])  #edit_one_monthに飛ぶ
  end
  
  private
  
  # requireメソッドで受け取るパラメータ群を、permitメソッドで利用可能なパラメータを指定する
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません"
        redirect_to(root_url)
      end
    end
end