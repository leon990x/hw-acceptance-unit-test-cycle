Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  match '/movies/:id/same', to: 'movies#same', as: 'similar_dir_movie', via: :get
end
