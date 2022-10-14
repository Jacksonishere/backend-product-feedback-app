FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    feedback { nil }
    parent_id { 1 }
  end
end
