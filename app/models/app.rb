class App < ActiveRecord::Base
   attr_accessible :name, :app_type_id

   validate :name, :presence => true
end
