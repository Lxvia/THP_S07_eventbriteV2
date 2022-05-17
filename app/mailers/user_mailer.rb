class UserMailer < ApplicationMailer
    default from: 'oliviarudolf67@gmail.com'
  layout 'mailer'

  def welcome_email(user)
    @user = user 
    @url = 'https://thp-eventbrite-app.herokuapp.com'
    mail(to: @user.email, subject: "Welcome to eventbrite !")
  end

  #def attendance_email(user)
    #@user = user
    #@url = 'http://bookevent.fr/login'
    #mail(to: @user.email, subject: "#{@user.first_name} ! Your participation to an even")
  #end
  
end
