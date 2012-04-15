class App < ActiveRecord::Base
   attr_accessible :name, :app_type_id

   validates :name, :presence => true

   default_scope :order => 'created_at DESC'
end
