class DogPolicy < ApplicationPolicy
  def admin?
    record.owner == current_user || current_user.admin?
  end
end