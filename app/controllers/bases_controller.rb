class BasesController < ApplicationController
  before_action :set_base, only: [ :destroy ]
  
  def new
  end
  
  def index
    @bases = Base.all
  end
  
  def destroy
    
    @base.destroy
    flash[:success] = "#{@base.base_name}のデータを削除しました"
    redirect_to bases_url(@base.base_id)
  end
  

end
