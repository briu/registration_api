class Api::V1::SessionsController < Api::V1::ApiController
  before_filter :ensure_user_login_param_exists, only: [:create]

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      render json: { success: true, auth_token: resource.authentication_token }, status: :created
      return
    end
    invalid_login_attempt
  end

  def destroy
    @user = User.find_for_database_authentication(authentication_token: params[:user][:auth_token])
    if @user.present?
      @user.authentication_token = nil
      @user.save
      render :json=> {:success=>true}
    else
      render :json=> {:success=>false}
    end
  end

  protected

  def ensure_user_login_param_exists
    ensure_param_exists :user
  end

  def ensure_param_exists(param)
    return unless params[param].blank?
    render json:{ success: false, message: "Missing #{param} parameter"}, status: :unprocessable_entity
  end

  def invalid_login_attempt
    render json: { success: false, message: "Error with your login or password"}, status: :unauthorized
  end
end
