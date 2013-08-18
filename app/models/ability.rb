class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new        # guest user

    if user.role? :Admin     # Admin does all
      can :manage, :all
    elsif user.role? :Author # Author edit and read
      can [:read, :edit, :update], [Article, Comment]
    elsif user.role? :Member
      can :read, :all
      can :create, [Comment]
      can [:edit, :update], Comment
    end
  end
end
