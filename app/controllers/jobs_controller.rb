class JobsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @jobs = JobService::find_all_by_user(current_user, params)
  end

  def new
    @job = JobService::build
  end

  def create
    @job = JobService::create_by_user(current_user, params[:job])
    if @job.persisted?
      redirect_to jobs_url, :notice => "Job added correctly."
    else
      flash.now[:warning] = "Some errors are occured. fix it please!"
      render :new
    end
  end

end
