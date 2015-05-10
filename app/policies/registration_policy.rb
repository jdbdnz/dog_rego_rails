class RegistrationPolicy < ApplicationPolicy
  def paid?
    current_user.admin?
  end

  def admin?
    record.owner == current_user || current_user.admin?
  end
end