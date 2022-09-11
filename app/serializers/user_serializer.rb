class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url
  # has_many :feedbacks

end
