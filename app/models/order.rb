class Order < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :trial_type
  belongs_to :laboratory
  has_many :trials


  validates_presence_of :doctor
  validates_presence_of :trial_type
  validates_presence_of :tracking_number
  validates_uniqueness_of :tracking_number
  validates_presence_of :order_date

  default_scope { includes(:doctor, :trial_type, trials: [:antibody, :pictures]).order(order_date: :desc) }

end
