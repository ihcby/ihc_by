class Order < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :trial_type
  has_many :trials


  validates_presence_of :doctor
  validates_presence_of :trial_type
  validates_presence_of :tracking_number
  validates_uniqueness_of :tracking_number
  validates_presence_of :order_date

  default_scope { order(order_date: :desc) }


  def not_used_antibodies
    Antibody.where.not(id: trials.map { |trial| trial.antibody_id })
  end


end
