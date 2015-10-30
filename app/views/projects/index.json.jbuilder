json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :notes
  json.url project_url(project, format: :json)
end