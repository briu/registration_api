class ApplicationController < ActionController::API
  before_filter :authenticate_user_from_token!
  include ActionController::MimeResponds

  private

  def authenticate_user_from_token!
    user_email = params[:user][:email].presence
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:auth_token])
      sign_in user, store: false
    end
  end
end
