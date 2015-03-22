class Picture < ActiveRecord::Base
  belongs_to :trial
  validates_presence_of :trial

  has_attached_file :image, styles: { large: '800x800>', medium: '300x300#', thumb: '150x150#', thumb_small: '30x30#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
