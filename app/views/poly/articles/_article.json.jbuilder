json.extract! article, :id, :author_id, :title, :created_at, :updated_at
json.name article.title
json.sgid article.attachable_sgid
json.content render(partial: "poly/articles/article", locals: { article: article }, formats: [:html])
json.url article_url(article)
