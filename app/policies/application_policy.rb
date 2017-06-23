class ApplicationPolicy
  attr_reader :user, :record

  def initialize user, record
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    index?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    if namespace
      Pundit::PolicyFinder.new([namespace, record.class]).scope.new(user, record.class).resolve
    else
      Pundit.policy_scope!(user, record.class)
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize user, scope
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  protected

    def owner?
      return false if user.blank?

      if record.respond_to? :user_id
        record.user_id == user.id
      else
        record.profile_id == profile.id
      end
    end

  private

    def namespace
      self.class.name.deconstantize.downcase.to_sym unless self.class.name.deconstantize.empty?
    end
end
