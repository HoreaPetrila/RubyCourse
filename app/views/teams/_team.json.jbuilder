# frozen_string_literal: true

json.extract! team, :id, :name
json.set! :manager do
  json.set! :first_name, team&.manager&.first_name
  json.set! :last_name, team&.manager&.last_name
  json.set! :age, team&.manager&.age
end
json.set! :logos_urls do
  json.array! team.logos do |logo|
    json.set! :url_array, rails_blob_url(logo)
  end
end

json.set! :variants do
  json.array! team.logos.each do |logo|
    json.set! :variant_array_small, rails_representation_url(logo.variant(resize: '100x100'))
    json.set! :variant_array_big, rails_representation_url(logo.variant(resize: '300x300'))
    json.set! :variant_array_large, rails_representation_url(logo.variant(resize: '500x500'))

  end
end

