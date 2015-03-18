json.array!(@antibodies) do |antibody|
  json.extract! antibody, :id, :name
  json.url antibody_url(antibody, format: :json)
end
