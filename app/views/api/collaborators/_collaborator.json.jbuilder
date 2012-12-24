json.(collaborator, :email)
json.name collaborator.woo(:name)
json.id collaborator.id.to_s
json.is_tmp collaborator.respond_to?(:create_user)
