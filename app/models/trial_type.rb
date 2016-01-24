class TrialType < ActiveRecord::Base
  belongs_to :laboratory

  default_scope { order(name: :asc) }
end
