class FeedbackSerializer
  include JSONAPI::Serializer
  attributes :title, :detail, :category, :status

  belongs_to :user
end
