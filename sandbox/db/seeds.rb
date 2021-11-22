require 'faker'
require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

def create_user(is_admin = nil)
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    is_admin: is_admin || false
  )
end

def create_article(user)
  title = Faker::Boolean.boolean(true_ratio: 0.5) ? Faker::Quote.famous_last_words : Faker::TvShows::HeyArnold.quote
  tag_list = %w[
          africa
          america
          angola
          antarctica
          asia
          europe
          business
          brazil
          coding
          entertainment
          finances
          media
          movies
          programming
          sciences
          social-sciences
          sports
          tourism
          travel
          trips
          united-states
      ]

  user.articles.create(
    title: title,
    status: Faker::Boolean.boolean(true_ratio: 0.9) ? :published : :unlisted,
    language: 'en',
    content: Faker::Lorem.paragraph(sentence_count: 24, supplemental: false, random_sentences_to_add: 7),
    excerpt: Faker::Lorem.paragraph(sentence_count: 4),
    is_private: Faker::Boolean.boolean(true_ratio: 0.01),
    discarded_at: Faker::Boolean.boolean(true_ratio: 0.01) ? Time.now : nil,
    tag_list: tag_list.sample(Faker::Number.rand(7)).join(',')
  )
end

def create_comment(user, commentable)
  user.comments.create(commentable: commentable, content: Faker::Lorem.sentence(word_count: 5))
end

def create_reaction(user, reactable, reaction)
  user.reactions.create(reactable: reactable, kind: reaction)
end


# ==============================
# Users
# ==============================
User.create(first_name: 'Leo', last_name: 'Neto', email: 'oleoneto@gmail.com', is_admin: true)

8.times do |index|
  user = create_user
  puts "Added user #{user.name}"

  # ==============================
  # Articles
  # ==============================

  if index % 2 == 0
    5.times do
      article = create_article(user)
      puts "Added article #{article.title} by #{article.author.name}"
    end
    puts "--------------------------------------------------------"
  end
end
