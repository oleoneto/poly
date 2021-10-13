require 'faker'

if User.all.count < 3
  puts "No users found..."
  3.times do
    User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email
    )
  end
end

# ==============================
# Articles
# ==============================
5.times do
  puts "Adding article"

  User.first.articles.create(
    title: Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 2),
    status: Faker::Boolean.boolean(true_ratio: 0.9) ? :published : :unlisted,
    content: Faker::Lorem.paragraph(sentence_count: 4, supplemental: false, random_sentences_to_add: 7),
    excerpt: Faker::Lorem.paragraph(sentence_count: 4),
    is_private: Faker::Boolean.boolean(true_ratio: 0.1),
    discarded_at: Faker::Boolean.boolean(true_ratio: 0.45) ? Time.now : nil
  )
end

# ==============================
# Reactions: Bookmarks, Comments, and Likes
# ==============================
Poly::Article.all.each do |article|
  User.first.reactions.create(reactable: article, kind: :bookmark)
  User.second.reactions.create(reactable: article, kind: :bookmark)
  User.last.reactions.create(reactable: article, kind: :bookmark)

  User.first.comments.create(commentable: article, content: Faker::Lorem.sentence(word_count: 5))
  User.last.comments.create(commentable: article, content: Faker::Lorem.sentence(word_count: 5))

  User.first.reactions.create(reactable: article, kind: :like)
  User.second.reactions.create(reactable: article, kind: :like)
  User.last.reactions.create(reactable: article, kind: :like)
end
