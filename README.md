Application Polweb
=========

To install this application, install on your OS Ruby 2.0.0 or greater, unzip the application in a folder then run in the app folder the following commands : 	`bundle install`
then start the server by `rails s` or 	`rails s -e production`
to set it to production environment. Set up a reverse proxy to point to the rails application server. 

If you are using IIS : [guide reverse proxy IIS][1]

[1]: http://www.iis.net/learn/extensions/configuring-application-request-routing-(arr)/creating-a-forward-proxy-using-application-request-routing

* Lors de l'utilisation d'un reverse proxy, le dossier `/public` doit être servis.
* Les gems (dépendances) sont définies dans `/Gemfile`. 
* Des filtres personnalisés pour WiceGrid sont définis dans `/config/initializers`.
* Il est nécessaire de fournir un login ActiveDirectory ou LDAP valide dans `config/intializers/adauth.rb` pour vérifier l'identité des utilisateurs.
* La connection à la base de données se fait via `/config/database.yml`. L'utilisation de SQL SERVER > 2012 n'est pas permise
* Dans l'application `session[:Qqchose]` fait appelle aux informations partagées par l'utilisateur et le serveur lors de la session, tel des cookies.
* Les filtres personnalisés ne sont pas compatible avec des SGBDD différent de MS SQL Server 