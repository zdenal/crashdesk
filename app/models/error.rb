class Error < ActiveResource::Base
  self.include_root_in_json = false
  self.site = "http://localhost:3001"
  self.prefix = "/app/:app_key/"
  self.primary_key = :key
  self.timeout = 3
end
