class Condition < ActiveRecord::Base
	self.table_name = 't_conditions'
	has_one :projet, foreign_key: 'id_conditions'
		self.primary_key = 'id'
end
