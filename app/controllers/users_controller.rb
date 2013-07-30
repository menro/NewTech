class UsersController < ApplicationController
  
  def index
  end

  def show
    puts "======================"
    puts params.inspect
    puts "****************************"
    @freelancer = User.where(username: params[:username].downcase).first
  end
end
