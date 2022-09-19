class Feedback < ApplicationRecord
  include Filterable
  
  default_scope { order(created_at: :desc) } 
  
  validates_length_of :detail, minimum: 1, maximum: 256
  
  belongs_to :user
  has_many :likes, as: :likeable

  scope :filter_by_category, -> (category) { where('category = ?', category) }
end
