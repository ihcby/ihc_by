class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    else

       can :manage, Account do |account|
          user.has_role?(:account_admin, account)
        end	  

      [Doctor, Laboratory].each do |resources_class|
        can :manage, resources_class do |resource|
          user.has_role?(:account_admin, resource.account)
        end
      end

      [Order, TrialType].each do |resources_class|
        can :manage, resources_class do |resource|
          user.has_role?(:account_admin, resource.laboratory.account)
        end
      end

      can :manage, Trial do |resource|
        user.has_role?(:account_admin, resource.order.laboratory.account)
      end

      can :manage, Picture do |resource|
        user.has_role?(:account_admin, resource.trial.laboratory.account)
      end

      can :read, Antibody
    end
  end
end
