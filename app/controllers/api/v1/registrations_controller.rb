class Api::V1::RegistrationsController < Api::V1::ApiController
  def create
    @fb = params[:user][:fb_id]
    @twt = params[:user][:fb_id]
    if @fb.present? || @twt.present?
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        render json: { success: true, auth_token: @user.authentication_token }, status: :created
      else
        warden.custom_failure!
        render :json=> @user.errors, :status=>422
      end
    else
      @user = User.new(params[:user])
      if @user.save
        render :json=> { :token=>@user.authentication_token }, :status=>201
        return
      else
        warden.custom_failure!
        render :json=> @user.errors, :status=>422
      end
    end
  end
end
