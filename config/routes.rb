Rails.application.routes.draw do
  resources :utilites

  get 'pages/about'

  match "/signout" => "sessions#destroy", via: [:get, :post]
  match "/adauth" => "sessions#create", via: [:get, :post]
  resources :sessions
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
mount Judge::Engine => '/judge' #moteur de validation
  # You can have the root of your site routed with "root"
  root 'dashboard#index'
  resources :clients, :dashboard, :offres, :items, :categorie_projets, :type_projets, :conditions, :prix_poids, :fournisseurs, :codification
resources :projets do
  resources :combustible_solides, :combustible_autres, :combustible_liquides, :combustible_gazeuxes, :matieres, :utilites
  get :autocomplete_projets_id, :on => :collection
end
  get 'tableau_croises' => 'tableau_croises#index'
  get 'tableau_croises/data' => 'tableau_croises#data'
 get 'codification' => 'codification#index'
  get 'choix_du_projet' => 'offres#choix_du_projet'
  get 'import_conditions' => 'conditions#import'
  post 'importer_conditions' => 'conditions#importer'
    get 'import_matieres' => 'matieres#import'
  post 'importer_matieres' => 'matieres#importer'
      get 'import_utilites' => 'utilites#import'
  post 'importer_utilites' => 'utilites#importer'
  get 'migration' => 'projets#migration'
  post 'migrer' => 'projets#migrer'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  post 'selection_du_projet' => 'offres#selection_du_projet'
  get 'recherche_des_items/:id' => 'codification#recherche_des_items'
  get 'recherche_des_items_avec_offre/:id' => 'codification#recherche_des_items_avec_offre'  
  get 'texte' => 'prix_poids#texte'
    get 'remarque' => 'prix_poids#remarque'
  get 'xl' => 'xl#index'
  get 'about' => 'pages#about'
  get 'recherche_g' => 'recherche#recherche_g'
    get 'recherche_a' => 'recherche#recherche_a'
  get 'recherche_u' => 'recherche#recherche_u'
  get 'recherche_m' => 'recherche#recherche_m'

  get 'recherche_c' => 'recherche#recherche_c'

  get 'recherche_l' => 'recherche#recherche_l'
  get 'recherche_s' => 'recherche#recherche_s'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
