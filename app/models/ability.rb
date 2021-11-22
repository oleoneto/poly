# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Poly::Article, is_private: false, status: :published
    can :read, Poly::Comment, is_private: false
    can :read, User

    return unless user.present?
    can :manage, Poly::Article, author: user
    cannot :create, Poly::Article unless user.is_admin

    can :manage, Poly::Comment, user: user

    can :manage, Poly::Archive, user: user

    can :manage, Poly::Trash, user: user

    can :manage, Poly::Share, user: user
    can :create, Poly::Share do |share|
      share.shareable.user == user
    end

    can :manage, User, id: user.id
  end
end
