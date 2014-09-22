class DashboardController < ApplicationController
def index
	#require 'wikipedia'
	session[:id_projet] = 0 #initialise la variable globale projet, pour émuler le comportement de sélection de projet de polflow 2
	@datum = []
	@listes_sites = []
	@recherche.each do |r| 
	@datum.push r[1]
	end

end
end