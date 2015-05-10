class RegistrationMailer < ApplicationMailer
  def created(registration)
    load_ivars registration
    mail(to: @user.email, subject: "#{@dog.name} is registered until #{ @dog.registered_until.strftime('%e %b %Y') }")
  end

  def paid(registration)
    load_ivars registration
    mail(to: @user.email, subject: "Registration payment received for #{@dog.name}")
  end

  private

  def load_ivars(registration)
    @registration = registration
    @user = registration.owner
    @dog  = registration.dog
  end
end
