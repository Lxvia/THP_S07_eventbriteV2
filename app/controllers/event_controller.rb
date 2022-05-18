class EventController < ApplicationController
    before_action :authenticate_user!, only: [:create, :new]

    def index #home
    end

    def show
        @event = Event.find(params[:id])
    end

    def new
        @event_new = Event.new# Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    end

    def create
        @event_new = Event.new(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin_id: current_user.id)

        if @event_new.save
            redirect_to event_path(@event_new.id)
        else
            render :new
        end
    end

end


