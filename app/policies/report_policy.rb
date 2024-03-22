class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end

    private

    attr_reader :user, :scope
  end
end
