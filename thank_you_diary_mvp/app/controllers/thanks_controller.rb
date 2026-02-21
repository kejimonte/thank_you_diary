class ThanksController < ApplicationController

  before_action :set_thank, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, except: [:show]

  def index
    @thanks = current_user.thanks.order(created_at: :desc)
  end

  def new
    @thank = Thank.new
  end

  def create
    @thank = current_user.thanks.build(thank_params)
    if @thank.save
      redirect_to thanks_path, notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
end

def update
  if @thank.update(thank_params)
    redirect_to thanks_path, notice: "更新しました"
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @thank.destroy
  redirect_to thanks_path, notice: "削除しました"
end

def show
  @thank = Thank.find(params[:id])
end

  private

  def thank_params
    params.require(:thank).permit(:content)
  end

  def set_thank
    @thank = Thank.find(params[:id])
  end

end
