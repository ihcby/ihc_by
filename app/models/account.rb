class Account < ActiveRecord::Base
  resourcify

  has_many :laboratories
  has_many :doctors
  has_many :trial_types, class_name: TrialType

  default_scope { includes(:doctors, :laboratories) }

  after_create :define_role
  after_destroy :destroy_role

  private
    def define_role
    roles.create(name: :account_admin)
  end

  def destroy_role
    roles.delete_all
  end

end
