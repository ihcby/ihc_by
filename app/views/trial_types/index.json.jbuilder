json.array!(@trial_types) do |trial_type|
  json.extract! trial_type, :id, :name, :laboratory_id
  json.url trial_type_url(trial_type, format: :json)
end
