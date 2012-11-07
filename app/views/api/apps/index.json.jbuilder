json.array!(@apps) do |app|
  json.(app, :name)
  json.id app.id.to_s
end
