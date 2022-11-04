require 'faker'

categories = %w(feature enhancement bug ui ux)
statuses = %w(suggestion planned in-progress live)

50.times do
  User.create(Faker::Internet.user('username', 'email', 'password').merge({
    :avatar_url => "https://avatars.dicebear.com/api/avataaars/#{Faker::Internet.uuid}.svg", 
    :full_name => "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    }))
end

500.times do
  Feedback.create(
    title: Faker::Lorem.sentence(word_count: 2, supplemental: false, random_words_to_add: 4),
    detail: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    category: categories[rand(0..4)],
    user_id: rand(1..30)
  )
end

2500.times do 
  rand_user_id = rand(User.first.id..User.last.id)
  rand_feedback_id = rand(1..500)

  User.find(rand_user_id).likes.create(likeable_type: "Feedback", likeable_id: rand_feedback_id)
end