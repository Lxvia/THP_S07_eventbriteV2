class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:secret] #Pouvoir acceder à une page uniquement en étant connecté

  def index
    @events = Event.all
    @user = current_user
  end

  def secret
    @user = current_user
  end

  def avatar
    @user = current_user
  end
end
