class UsersController < ApplicationController
  before_filter :store_return_to
  def index
  end

  def show
    @freelancer = User.where(username: params[:username].downcase).first
  end

  def edit_profile
    @freelancer = User.where(username: params[:username].downcase).first
    unless current_user || (current_user && current_user.id == @freelancer.id)
      redirect_to(show_freelancer_users_path(@freelancer.username))
    end
  end

  def update
    @freelancer = User.where(username: params[:username]).first
    if @freelancer.update_attributes(params[:user])
      redirect_to show_freelancer_users_path(@freelancer.username), notice: 'Your profile has been updated successfully'
    else
      render 'edit_profile'
    end
  end

  private

  def store_return_to
    session[:return_to] = request.url
  end

end
