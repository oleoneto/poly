json.extract! user, :id, :first_name, :last_name, :name
json.sgid user.attachable_sgid
json.content render(partial: "poly/users/user", locals: { user: user }, formats: [:html])
json.url user_url(user)
