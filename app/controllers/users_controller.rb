class UsersController < ApplicationController
  respond_to :json, :html
  before_filter :store_return_to

  def index
    @users_status = []
    if params && params[:search].present?
      discipline_id = params[:search][:developer]
    else
      discipline_id = Discipline.where(name: 'Developer').first.id
    end
    @platforms_on_page = Platform.where("on_page=? and discipline_id=?", true, discipline_id)
    @platforms_popup = Platform.where("on_page=? and discipline_id=?", false, discipline_id)
    @languages_on_page = Language.where("on_page=? and discipline_id=?", true, discipline_id)
    @languages_popup = Language.where("on_page=? and discipline_id=?", false, discipline_id)

    User::WORK_STATUS.each do |status|
      users = []
      if params[:search].present? && (params[:search][:platforms_in].present? || params[:search][:languages_in].present? || params[:search][:developer].present?)
        users = User.joins(:platforms).where('platform_id IN (?) and status=? and users.discipline_id=?', params[:search][:platforms_in], status, discipline_id).all
        users += User.joins(:languages).where('language_id IN (?) and status=? and users.discipline_id=?', params[:search][:languages_in], status, discipline_id).all
        users += User.where("status=? and is_freelancer=? and discipline_id=?", status, true, discipline_id).all unless (params[:search][:platforms_in].present? || params[:search][:languages_in].present?)
      elsif params[:platform].present?
        p = Platform.where(name: params[:platform]).first
        users = User.joins(:platforms).where('platform_id =? and status=? and users.discipline_id=?', p.id, status, discipline_id).all
      elsif params[:language].present?
        l = Language.where(name: params[:language]).first
        users = User.joins(:languages).where('language_id=? and status=? and users.discipline_id=?', l.id, status, discipline_id).all
      else
        users = User.where("status=? and is_freelancer=? and discipline_id=?", status, true, discipline_id).all
      end
      @users_status << [status, users.uniq]
    end
    respond_with(@users_status, :layout => !request.xhr? )
  end

  def show
    @freelancer = User.where(username: params[:username].downcase).first
  end

  def edit_profile
    @freelancer = User.where(username: params[:username].downcase).first
    unless current_user || (current_user && current_user.id == @freelancer.id)
      redirect_to show_freelancer_users_path(@freelancer.username)
    end
    discipline = Discipline.where(name: 'Developer').first
    @disciplines = Discipline.all
    @discipline_platforms = discipline.platforms.map {|d| [d.name.titleize, d.id]}
    @discipline_languages = discipline.languages.map {|d| [d.name.titleize, d.id]}
  end

  def update
    @freelancer = User.where(username: params[:username]).first
    if @freelancer.update_attributes(params[:user])
      redirect_to show_freelancer_users_path(@freelancer.username), notice: 'Your profile has been updated successfully'
    else
      render 'edit_profile'
    end
  end
  
  def fetch_discipline
    puts "233333"
    debugger
    puts params
  end

  def change_status
    puts params
    current_user.update_attribute(:status, params[:user][:status])
    render nothing: true
  end

  def endorse
    @freelancer = User.where(username: params[:username]).first #recommendi => being endorsed
    skill_ids = params[:user][:user_skill_ids].reject {|id| id.empty?}
    # current_user.user_skills = User.find(current_user.id).user_skills
    skill_ids.each do |id|
      recomendation = Recommendation.new
      recomendation.skill_type_id = id
      recomendation.recommendi_id = @freelancer.id
      current_user.recommendations << recomendation
      @freelancer.user_skills << SkillType.find(id)
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
