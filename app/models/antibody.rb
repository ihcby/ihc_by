class Antibody < ActiveRecord::Base
  default_scope { order(name: :asc) }
  validates_presence_of :name
  validates_uniqueness_of :name
end
