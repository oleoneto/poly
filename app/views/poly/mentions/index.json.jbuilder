json.array! @tags, partial: "poly/tags/tag", as: :tag
json.array! @users, partial: "poly/users/user", as: :user
json.array! @articles, partial: "poly/articles/article", as: :article
