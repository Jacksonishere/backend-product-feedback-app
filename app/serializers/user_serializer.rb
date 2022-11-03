class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url, :full_name
  # has_many :feedbacks
  # has_many :likes

end
