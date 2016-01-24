class Trial < ActiveRecord::Base
  belongs_to :antibody
  belongs_to :order
  has_many :pictures
end
