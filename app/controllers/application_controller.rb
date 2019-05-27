class ApplicationController < ActionController::Base
  def user_logged?
    unless user_signed_in?
      p '==================================================================================='
      render json: {'status': 'error'}, status: :forbidden
      return false
    end

    return true
  end
end
