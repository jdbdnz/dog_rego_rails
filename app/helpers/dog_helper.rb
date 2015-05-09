module DogHelper
  def dog_status_glyphicon(dog)
    case dog.registration_status
    when Dog::STATUS_REGISTERED
      'glyphicon-ok'
    when Dog::STATUS_PENDING_PAYMENT
      'glyphicon-exclamation-sign'
    when Dog::STATUS_NOT_REGISTERED
      'glyphicon-remove'
    end
  end
end