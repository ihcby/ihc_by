class Doctor < ActiveRecord::Base
  belongs_to :account

  default_scope { order(name: :asc) }
end
