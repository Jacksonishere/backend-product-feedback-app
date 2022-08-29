class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :avatar_url, :email
end
