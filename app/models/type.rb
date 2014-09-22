class Type < ActiveRecord::Base
	self.table_name = 't_type'
	has_many :projet, foreign_key: 'id_type'
		self.primary_key = 'id'
  # disable STI car 'type' est interdit comme nom de table
  self.inheritance_column = :_type_disabled

end
