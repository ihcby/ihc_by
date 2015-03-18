class Role < ActiveRecord::Base
  has_many :users, through: :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
