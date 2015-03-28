class Account < ActiveRecord::Base
  has_many :laboratories
  has_many :doctors
  has_many :trial_types, class_name: TrialType

  default_scope { includes(:doctors, :laboratories) }
end
