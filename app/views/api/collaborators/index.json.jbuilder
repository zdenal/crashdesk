json.array!(@collaborators) do |collaborator|
  json.partial! "api/collaborators/collaborator", collaborator: collaborator
end
