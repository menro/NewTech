class UsersController < ApplicationController
  respond_to :json, :html
  before_filter :store_return_to

  def index
    @users_status = []
    if params && params[:search].present?
      discipline_id = params[:search][:developer]
    elsif params && params[:discipline_id].present?
      discipline_id = params[:discipline_id]
    else
      discipline_id = Discipline.where(name: 'Developer').first.id
    end

    @disciplines = Discipline.all
    is_freelancer = true
    limit = 6
    fconifgs = FreelancerConfig.first
    endorse_count = fconifgs.endorse_count
    if params[:search] && params[:search][:browse_all] == 'true'
       @users_status = User.browse_all
     else
      User::WORK_STATUS.each do |status|
        users = []
        if params[:search].present? && params[:search][:developer].present?
          if (params[:search][:platforms_in].present? || params[:search][:languages_in].present?)
            users = User.joins(:platforms).joins(:languages).where('(platform_id IN (?) or language_id IN (?)) and status=? and users.discipline_id=? and is_freelancer=? and endorsers_count >= ? ',params[:search][:platforms_in],  params[:search][:languages_in], status, discipline_id, is_freelancer, endorse_count).order('endorsers_count DESC').limit(limit)
          else
            users += User.where("status=? and is_freelancer=? and discipline_id=? and endorsers_count >= 3 ", status, true, discipline_id).limit(limit)
          end
        elsif params[:platform].present?
          p = Platform.where(name: params[:platform]).first
          users = User.joins(:platforms).where('platform_id =? and status=? and users.discipline_id=? and is_freelancer=? and endorsers_count >= ? ', p.id, status, discipline_id, is_freelancer, endorse_count).order('endorsers_count DESC').limit(limit)
        elsif params[:language].present?
          l = Language.where(name: params[:language]).first
          users = User.joins(:languages).where('language_id=? and status=? and users.discipline_id=? and is_freelancer=? and endorsers_count >= ? ', l.id, status, discipline_id, is_freelancer, endorse_count).order('endorsers_count DESC').limit(limit)
        else
          users = User.where("status=? and is_freelancer=? and discipline_id=? and endorsers_count >= ?", status, true, discipline_id, endorse_count).order('endorsers_count DESC').limit(limit)
        end
        @users_status << [status, users.uniq]
      end
    end
    respond_with(@users_status, :layout => !request.xhr? )
  end

  def fetch_more
    @user_status = []
    discipline_id = params[:discipline_id]
    status = params[:status]
    platforms_in = params[:platforms_in]
    languages_in = params[:languages_in]
    users = []
    offset = 6
    if (platforms_in.present? || languages_in.present?)
      # queries can be refactor here
      exclude_users = User.joins(:platforms).joins(:languages).select('users.id').where('(platform_id IN (?) or language_id IN (?)) and status=? and users.discipline_id=? and is_freelancer=? and endorsers_count >= 3', platforms_in, languages_in, status, discipline_id, is_freelancer).limit(6)
      users = User.joins(:platforms).joins(:languages).where('(platform_id IN (?) or language_id IN (?)) and status=? and users.discipline_id=? and is_freelancer=? and users.id NOT IN(?)', platforms_in, languages_in, status, discipline_id, is_freelancer, exclude_users.collect(&:id)).order('endorsers_count DESC')
    else
      exclude_users = User.select('id').where("status=? and is_freelancer=? and discipline_id=? and endorsers_count >= 3", status, true, discipline_id).limit(6)
      users = User.where("status=? and is_freelancer=? and discipline_id=? and id NOT IN(?)", status, true, discipline_id, exclude_users.collect(&:id)).order('endorsers_count DESC')
    end
    @user_status = users.uniq
    respond_with(@user_status, :layout => !request.xhr? )
  end

  def show
    @freelancer = User.where(username: params[:username].downcase).first
    if @freelancer.present? && !@freelancer.is_freelancer?
      redirect_to profile_path
    end
  end

  def edit_profile
    @freelancer = User.where(username: params[:username].downcase).first
    if current_user.nil? || (current_user.id != @freelancer.id)
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
      discipline = Discipline.where(name: 'Developer').first
      @disciplines = Discipline.all
      @discipline_platforms = discipline.platforms.map {|d| [d.name.titleize, d.id]}
      @discipline_languages = discipline.languages.map {|d| [d.name.titleize, d.id]}
      render 'edit_profile'
    end
  end

  def change_status
    current_user.status = params[:user][:status]
    current_user.bump += 1
    current_user.save    
    render nothing: true
  end

  def endorse
    @freelancer = User.where(username: params[:username]).first
    skill_id = params[:skill_id]
    skill_type = params[:skill_type]
    rec = Recommendation.where("skillable_id=? and skillable_type=? and recommendi_id=? and user_id =?", skill_id, skill_type, @freelancer.id, current_user.id).first
    if rec.blank?
      recomendation = Recommendation.new
      recomendation.skillable_id = skill_id
      recomendation.skillable_type = skill_type.classify
      recomendation.recommendi_id = @freelancer.id
      current_user.recommendations << recomendation
      current_user.endorsers_count = current_user.top_endorsers_count
      current_user.save
    end
  end

  def add_user_link
    link = params[:user_link]
    link = link.gsub('http://', '').gsub('https://', '').gsub('www.', '')
    name = link.split('.').first
    current_user.users_links << UsersLink.create({name: name.titleize, link_url: params[:user_link]})
    render json: current_user.users_links.last.to_json
  end

  def remove_user_link
    user_link = UsersLink.find(params[:id])
    user_link.delete
    render text: :ok
  end

  def remove_recommendation
    recomendation = Recommendation.find(params[:id])
    recomendation.delete
    current_user.endorsers_count = current_user.top_endorsers_count
    current_user.save
    render text: :ok
  end

  private

  def store_return_to
    session[:return_to] = request.url
  end

end
