json.extract! tag, :id, :name
json.sgid tag.attachable_sgid
json.content render(partial: "poly/tags/tag", locals: { tag: tag }, formats: [:html])
json.url tag_url(tag.name)
