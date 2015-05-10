class UserPolicy < ApplicationPolicy
  def index?
    current_user.admin?
  end

  def admin?
    record == current_user || current_user.admin?
  end
end