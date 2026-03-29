class ThanksController < ApplicationController
  before_action :set_thank, only: [:show]
  before_action :set_own_thank, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @thanks = Thank.includes(:tags)

    if params[:keyword].present?
      keyword = params[:keyword]

      @thanks = @thanks
        .left_joins(:tags)
        .where("thanks.content LIKE ? OR tags.name LIKE ?", "%#{keyword}%", "%#{keyword}%")
        .distinct
    end

    if params[:tag].present?
      tag = Tag.find_by(name: params[:tag])
      @thanks = tag ? @thanks.joins(:tags).where(tags: { id: tag.id }) : Thank.none
    end

    @thanks = @thanks.order(created_at: :desc)
  end

  def new
    @thank = Thank.new
  end

  def create
    @thank = current_user.thanks.build(thank_params)
    if @thank.save
      save_tags(@thank)
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
    set_meta_tags(
      title: @thank.content,
      description: @thank.content.truncate(100),
      og: {
        title: @thank.content,
        description: @thank.content.truncate(100),
        image: view_context.image_url("ogp.png"),
        image_width: 1200,
        image_height: 630
      }
    )
  end

  def ai_generate
    text = params[:content]

    if text.blank?
      render json: { text: "内容を入力してください" }
      return
    end

    result = OpenaiService.generate(text)

    render json: { text: result }
  end

  private

  def thank_params
    params.require(:thank).permit(:content, :image)
  end

  def set_thank
    @thank = Thank.find_by(id: params[:id])
    redirect_to root_path, alert: "投稿が見つかりません" unless @thank
  end

  def set_own_thank
    @thank = current_user.thanks.find_by(id: params[:id])
    redirect_to root_path, alert: "権限がありません" unless @thank
  end

  def save_tags(thank)
    return if params[:tag_names].blank?

    tag_names = params[:tag_names].split(',')

    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip)
      thank.tags << tag
    end
  end
end
