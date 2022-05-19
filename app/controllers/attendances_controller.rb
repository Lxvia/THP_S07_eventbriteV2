class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.create
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @user = current_user
    @stripe_amount = @event.price

    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount *100,
        description: "Frais d'incription à un event",
        currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path
    end

    @attendance = Attendance.new(stripe_customer_id: customer.id, user: @user, event: @event)
    puts @attendance.inspect

    if @attendance.save
      puts @attendance.inspect
      redirect_to event_path(params[:event_id])
    else 
      puts @attendance.inspect
      flash.now[:alert] = @attendance.errors.full_messages
      render 'new'
    end
    
  end
end
