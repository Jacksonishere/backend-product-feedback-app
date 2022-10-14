class Like < ApplicationRecord
  # multiple likes can belong to the same user, but the combination of the user_id with the thing_liked along with the thing_liked_type have to be unique
  # this is because user_9 can like a likeable thing if id_9 but also of another likeable thing of id_9
  # if we don't include likeable_type also, it will be considered invalid
  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }

  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :likeable_count
end
