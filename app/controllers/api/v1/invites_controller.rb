class Api::V1::InvitesController < Api::V1::ApiController
  def invite
    @user = User.find(params[:user][:id])
    if @user.fb_id.present?
      fb_user = FbGraph::User.fetch('#{@user.fb_id', :access_token => "#{@user.fb_access_token}")
      fb_user.friends.each do |friend|
        app_request = fb_user.app_request!(
          :message => 'Connect to my app!',
          :to      => friend.id
          )
      end if fb_user.friends.present?
    else
      render json: { success: false, message: "This user haven't fb auth!"}, status: :unauthorized
    end
  end
end
