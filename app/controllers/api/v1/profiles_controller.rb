class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/profile
  def show
    render json: current_user
  end

  # PATCH /api/v1/profile
  def update
    if current_user.update(profile_params)
      render json: current_user
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/profile/change_password not working fixed later
  def change_password
    if current_user.valid_password?(params[:current_password])
      if current_user.update(password: params[:new_password])
        render json: { message: 'Password updated successfully' }
      else
        render json: { errors: current_user.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Current password is incorrect'] }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :name,
      :email,
      :profile_picture
      )
  end
end