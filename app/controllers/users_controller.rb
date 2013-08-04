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
      redirect_to show_freelancer_users_path(@freelancer.username)
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

  def change_status
    puts params
    current_user.update_attribute(:status, params[:user][:status])
    render nothing: true
  end

  def endorse
    puts params
    @freelancer = User.where(username: params[:username]).first #recommendi => being endorsed
    skill_ids = params[:user][:user_skill_ids].reject {|id| id.empty?}
    current_user.user_skill_ids << skill_ids
    skill_ids.each do |id|
      recomendation = Recommendation.new
      recomendation.skill_type_id = id
      recomendation.recommendi_id = @freelancer.id
      current_user.recommendations << recomendation
    end
    if current_user.save
      redirect_to show_freelancer_users_path(@freelancer.username), notice: "Thanks for endorsing #{@freelancer.name}!"
    end
  end

  private

  def store_return_to
    session[:return_to] = request.url
  end

end
