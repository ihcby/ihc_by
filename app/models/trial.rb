class Trial < ActiveRecord::Base
  belongs_to :antibody
  belongs_to :laboratory
  has_many :pictures
end
