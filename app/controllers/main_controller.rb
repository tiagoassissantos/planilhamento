class MainController < ApplicationController
  def index
    redirect_to '/user-area' if user_signed_in?
  end
end
