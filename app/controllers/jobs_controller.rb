class JobsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @jobs = JobService::find_all_by_user(current_user, params)
  end

  def new
    @job = JobService::build
  end

  def create
    @job = JobService.create_by_user(current_user, params[:job])
    if @job.persisted?
      redirect_to jobs_url, :notice => "Job added correctly."
    else
      flash.now[:warning] = t(:some_errors_have_occured)
      render :new
    end
  end

  def edit
    @job = JobService.edit_by_user(current_user, params[:id])
  end

  def update
    @job = JobService.update_by_user(current_user, params[:id], params[:job])
    if @job.errors.empty?
      redirect_to jobs_url, :notice => "Job updated correctly."
    else
      flash.now[:error] = @job.errors.full_messages.join(" ")
      render :edit
    end
  end

  def destroy
    JobService.destroy_by_user(current_user, params)
    redirect_to :back, :notice => "Job deleted successfully."
  end

end
