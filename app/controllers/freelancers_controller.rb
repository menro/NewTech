class FreelancersController < ApplicationController
  
  def index
  end

  def show
    puts "======================"
    puts params.inspect
    puts "****************************"
    @freelancer = Freelancer.where(username: params[:username].downcase).first

  end
end
