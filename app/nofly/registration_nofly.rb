class RegistrationNofly < Nofly::EventLibrary
  def registered
    #send email to owner confirming their dog's registration
    RegistrationMailer.registered(registration).deliver_now!
  end

end