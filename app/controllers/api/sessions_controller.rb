class Api::SessionsController < ApplicationController
    
  def create
    user = User.find_by(email: sessions_params[:email])

    if user&.authenticate(sessions_params[:password])
      token = Jwt::TokenProvider.call(user_id: user.id)
      render json: ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer).as_json.deep_merge(user: { token: token })
    else
      render json: { error: { messages: ['mistake emal or password'] } }, status: :unauthorized
    end
  end

  private

  def sessions_params
    params.require(:sessions).permit(:email, :password)
  end
end 