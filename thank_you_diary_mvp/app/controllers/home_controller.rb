class HomeController < ApplicationController
  def index
    @thanks = Thank.order(created_at: :desc)
  end
end
