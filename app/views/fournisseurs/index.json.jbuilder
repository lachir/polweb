json.array!(@fournisseurs) do |fournisseur|
  json.extract! fournisseur, :id, :nom, :pays
  json.url fournisseur_url(fournisseur, format: :json)
end
