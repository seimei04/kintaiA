class BasesController < ApplicationController
  before_action :set_base, only: [ :destroy, :update ]
  
  def new
      @base = Base.new
  end
  
  def index
    @bases = Base.all
  end
  
  def create
    @base = Base.new(base_info_params)
    if @base.save
      flash[:success] = '新規作成に成功しました'
      #redirect_to @base
    else
      #render :new
      flash[:danger] = "新規作成に失敗しました。<br>" + @base.errors.full_messages.join("<br>")
    end
    redirect_to bases_path
  end

  def destroy
    @base.destroy
    flash[:success] = "#{@base.base_name}のデータを削除しました"
    redirect_to bases_url(@base.id)
  end
  
  
   def update
     if @base.update_attributes(base_info_params) 
       flash[:success] = "#{@base.base_name}の基本情報を更新しました。"
     else
       flash[:danger] = "#{@base.base_name}の更新は失敗しました。<br>" + @base.errors.full_messages.join("<br>")
     end
       redirect_to bases_url
   end
   
   private
     def base_info_params
      params.require(:base).permit(:id, :base_name, :base_type )
     end

end
