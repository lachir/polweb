class CombustibleLiquide < ActiveRecord::Base
	self.table_name = 't_combustibles_liquides'
	belongs_to :projet, foreign_key: 'id_projet'
end
