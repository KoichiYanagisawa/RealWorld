class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      @user[:token] = generate_jwt(@user)
      User.update(id: @user.id)
      render json: { user: @user.as_json(only: %i[username email token bio image]) }, status: :created
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
