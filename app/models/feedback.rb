class Feedback < ApplicationRecord
  include Filterable
  include Sortable
  
  default_scope { order(created_at: :desc) } 
  
  validates_length_of :detail, minimum: 1, maximum: 256
  
  belongs_to :user
  has_many :likes, as: :likeable

  scope :filter_by_category, -> (category) { where('category = ?', category) }
  
  scope :sort_by_likes, -> (order) { 
    left_joins(:likes). # left join to generate rows with feedback and like cols
    group(:id).      # group the rows by feedback id, so we can run aggregate functions
    order("count(likes.id) #{order}")
   }
end
