class CombustibleGazeux < ActiveRecord::Base
	self.table_name = 't_combustibles_gazeux'
	belongs_to :projet, foreign_key: 'id_projet'
		self.primary_key = 'id'
end
