class HomeController < ApplicationController
  def index
    @thanks = Thank.order(created_at: :desc)

    if user_signed_in?
      @thanks_count = current_user.thanks.count
    end
  end
end
