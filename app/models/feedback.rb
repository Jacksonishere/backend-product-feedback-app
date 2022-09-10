class Feedback < ApplicationRecord
  validates_length_of :detail, minimum: 1, maximum: 256
  
  belongs_to :user
end
