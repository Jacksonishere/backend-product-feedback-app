require 'faker'

categories = %w(feature enhancement bug UI UX)
statuses = %w(suggestion planned in-progress live)

30.times do
  User.create(Faker::Internet.user('username', 'email', 'password').merge({:avatar_url => "https://avatars.dicebear.com/api/avataaars/#{Faker::Internet.uuid}.svg"}))
end

250.times do
  Feedback.create(
    title: Faker::Lorem.sentence(word_count: 2, supplemental: false, random_words_to_add: 4),
    detail: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    category: categories[rand(0..4)],
    status: "suggestion",
    user_id: rand(1..30)
  )
end
