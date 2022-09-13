class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url
  # has_many :feedbacks
  # has_many :likes

end
