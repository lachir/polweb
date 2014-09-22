class CombustibleSolide < ActiveRecord::Base
	self.table_name = 't_combustibles_solides'
	belongs_to :projet, foreign_key: 'id_projet'
		self.primary_key = 'id'
end
