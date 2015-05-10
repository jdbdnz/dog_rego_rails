class RegistrationNofly < Nofly::EventLibrary
  
  def created
    #send email to owner confirming their dog's registration
    RegistrationMailer.created(registration).deliver_now!
  end

  def paid
    RegistrationMailer.paid(registration).deliver_now!
  end

end