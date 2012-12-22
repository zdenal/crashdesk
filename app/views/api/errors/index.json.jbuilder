json.array!(@errors) do |error|
  json.(error, :title, :deadline, :no, :persons, :tags, :crc)
  json.id error.id.to_s
  json.app_id error.app.id.to_s
end
