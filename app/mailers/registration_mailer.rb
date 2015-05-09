class RegistrationMailer < ApplicationMailer
  def registered(registration)
    @user = registration.owner
    @dog  = registration.dog
    mail(to: @user.email, subject: "#{@dog.name} is registered until #{ @dog.registered_until.strftime('%e %b %Y') }")
  end
end
