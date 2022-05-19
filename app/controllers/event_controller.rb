class EventController < ApplicationController
    before_action :authenticate_user!, only: [:create, :new, :edit]

    def index #home
    end

    def show
        @event = Event.find(params[:id])
        @user = current_user
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

    def edit

        @event = Event.find(params[:id])

        if @event.admin_id != current_user.id
            redirect_to :root
        end
        
        # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    end
      
    def update

        @event = Event.find(params[:id])

        post_params = params.permit(:start_date, :duration, :title, :description, :price, :location)

        if @event.update(post_params)
            render :show
            flash[:succes] = "Event updated !"
        else 
            render :edit
            flash[:danger] = "Event not updated" 
        end
        # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
        # pour info, le contenu de ce formulaire sera accessible dans le hash params
        # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to :root
    end

end


