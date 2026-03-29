class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def create
    @thank = Thank.find(params[:thank_id])
    @comment = @thank.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to thank_path(@thank), notice: "コメント投稿しました"
    else
      redirect_to thank_path(@thank), alert: "コメント失敗"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
