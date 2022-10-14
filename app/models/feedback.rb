class Feedback < ApplicationRecord
  include Filterable
  
  validates_length_of :detail, minimum: 1, maximum: 256
  
  scope :filter_by_category, -> (category) { 
    where('category = ?', category) 
  }
  
  scope :sort_by_likes, -> (order) { 
    left_joins(:likes). # left join to generate rows with feedback and like cols
    group(:id).      # group the rows by feedback id, so we can run aggregate functions
    order("count(likes.id) #{order}, feedbacks.created_at desc")
   } 

  belongs_to :user
  has_many :likes, as: :likeable, dependent: :delete_all
  has_many :comments
end
