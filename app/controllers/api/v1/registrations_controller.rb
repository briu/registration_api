class Api::V1::RegistrationsController < Api::V1::ApiController
  def create
    @fb = params[:user][:fb_id]
    @twt = params[:user][:twt_id]
    if @fb.present?
      if(@user = User.find_by_fb_id(@fb))
        @user.ensure_authentication_token
        return
      else
        @user = User.new(params[:user])
        if @user.save
          render json: { success: true, auth_token: @user.authentication_token }, status: :created
        else
          render :json=> @user.errors, :status=>422
        end
      end
    elsif @twt.present?
      if(@user = User.find_by_fb_id(@twt) and !@fb.present)
        @user.ensure_authentication_token
        return
      else
        @user = User.new(params[:user])
        if @user.save
          render json: { success: true, auth_token: @user.authentication_token }, status: :created
        else
          render :json=> @user.errors, :status=>422
        end
      end
    else
      @user = User.new(params[:user])
      if @user.save
        render :json=> { :token=>@user.authentication_token }, :status=>201
        return
      else
        render :json=> @user.errors, :status=>422
      end
    end
  end
end
