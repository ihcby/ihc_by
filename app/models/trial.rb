class Trial < ActiveRecord::Base
  belongs_to :antibody
  belongs_to :laboratory
end
