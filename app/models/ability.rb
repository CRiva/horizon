class Ability
  include CanCan::Ability

  def initialize(user)
    ## to get id numbers for each user go to rails console and type:
    ## Role.all
    ## in new dev environment you must set up roles in console with:
    ## r = Role.new
    ## r.name = "[role_name]"
    ## r.save
    ## do them in order, or update the id numbers.

    user ||= User.new        # guest user

    if user.role? :Admin     # ID = 1 Admin does all
      can :manage, :all
    elsif user.role? :Editor # ID = 2 has writers and owns a section
      can :read, :all
      can [:create, :edit, :update], [Article]
    elsif user.role? :Member # ID = 3 member is a reader, who can comment.
      can :read, :all
      can :create, [Comment]
    end
  end
end
