class Api::V1::RegistrationsController < Api::V1::ApiController
  def create
    user = User.new(params[:user])
    if user.save
      render :json=> { :token=>user.authentication_token }, :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end
end
