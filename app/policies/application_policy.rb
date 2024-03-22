class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user.present? && (user == record.user)
  end

  def update?
    # edit?
    true
  end

  def destroy?
    # edit?
    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
