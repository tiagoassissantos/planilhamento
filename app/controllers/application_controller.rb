class ApplicationController < ActionController::Base
  after_action :registry_log, only: [:create, :update, :destroy]


  def user_logged?
    unless user_signed_in?
      render json: {'status': 'error'}, status: :forbidden
      return false
    end

    return true
  end


  def registry_log
    p '+++++++++++++=============++++++++++++++++++++++'
    p action_name
    p controller_name

    Log.create( 
      user: current_user, 
      action: action_name, 
      registry: controller_name, 
      description: @registry 
    )
  end
end
