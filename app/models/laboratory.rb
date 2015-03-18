class Laboratory < ActiveRecord::Base
  has_many :trial_types
  has_many :orders
  belongs_to :account
end
