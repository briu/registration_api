class Api::V1::AuthenticationsController < Api::V1::ApiController
  def twitter
    omni = request.env["omniauth.auth"]
    authentication = User.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication
      sign_in(@user = User.find(authentication.user_id))
      user.ensure_authentication_token
      render :json=> { :token=>user.authentication_token }, :status=>201
    else
      @user = User.new(:provider => omni['provider'],
                      :uid => omni['uid'],
                      :token => omni['credentials'].token
                      )
      if @user.save
        sign_in @user
        render json: { success: true, auth_token: user.authentication_token}, status: :created
      else
        render json: { success: false }, status: :unauthorized
      end
    end
  end

  def facebook
    omni = request.env["omniauth.auth"]
    authentication = User.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication
      sign_in(@user = User.find(authentication.user_id))
      user.ensure_authentication_token
      render :json=> { :token=>user.authentication_token }, :status=>201
    else
      @user = User.new(:provider => omni['provider'],
                      :uid => omni['uid'],
                      :token => omni['credentials'].token
                      )
      if @user.save
        sign_in @user
        render json: { success: true, auth_token: user.authentication_token}, status: :created
      else
        render json: { success: false }, status: :unauthorized
      end
    end
  end
end
