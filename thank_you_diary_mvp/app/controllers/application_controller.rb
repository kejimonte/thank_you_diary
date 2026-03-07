class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_default_meta_tags

  def index
  end

  def after_sign_in_path_for(resource)
    root_path
  end


  def set_default_meta_tags
    set_meta_tags(
      site: "Thank You Diary",
      title: "感謝を記録する日記アプリ",
      description: "日々の感謝を記録してポジティブな習慣を作るアプリです。",
      keywords: "感謝,日記,ポジティブ",
      canonical: request.original_url,
      og: {
        site_name: "Thank You Diary",
        title: "Thank You Diary",
        description: "日々の感謝を記録するアプリ",
        type: "website",
        url: request.original_url,
        image: view_context.image_url("ogp.png")
      },
      twitter: {
        card: "summary_large_image"
      }
    )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :nickname ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :nickname ])
  end
end
