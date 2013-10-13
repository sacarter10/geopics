GeoPics::Application.routes.draw do
  root to: "root#root"

  # so the search parameters don't look like a venue id and hit show controller
  get "venues/by_location", to: "venues#index" 
  resources :venues, :only => [:show]
end
