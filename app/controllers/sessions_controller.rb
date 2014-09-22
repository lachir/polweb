class SessionsController < ApplicationController
	#controlleur qui gère l'authentification par Active Directory LDAP via la gem adauth. Voir le fichier config/initializer/adauth.rb pour le configurer
	def new
		#render plain: session[:return_to]
	end

	def create
		ldap_user = Adauth.authenticate(params[:username], params[:password]) # Username et password sont les ids d'utilisateur windows
		if ldap_user
        	
         if ldap_user.ldap_object[:memberof].include? "CN=PolFlow_writers,CN=Users,DC=polmed,DC=fr" # vérifie si l'utilisateur est inscrit dans le groupe polflow_writer
         	session[:ecriture] = true #donne les droits d'écriture pour la session, génère un cookie
           	session[:editeur] = ldap_user.ldap_object[:samaccountname][0]
           	unless session[:return_to] == nil
           		redirect_to url_for(session[:return_to]), notice: 'Vous avez à présent les droits d\'écriture'
           	else
     		redirect_to root_path, notice: 'Vous avez à présent les droits d\'écriture'
     		end
         else
         	session[:ecriture] = false
           	unless session[:return_to] == nil
           		redirect_to url_for(session[:return_to]), notice: 'Vous n\'avez pas les droits d\'écriture'
           	else
     		redirect_to root_path, notice: 'Vous n\'avez pas les droits d\'écriture'
     		end
         end
    	else
        	redirect_to root_path, alert: "Login invalide" #le login n'a pas été trouvé ou est invalide
    	end
	end

	def destroy
		session[:ecriture] = false
		session[:editeur] = ''
		 flash[:notice] = "Vous êtes déconnecté"
		redirect_to root_path
	end
end