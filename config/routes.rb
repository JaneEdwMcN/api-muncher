Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#main'

  # get "/recipes/search", to: "recipes#search", as: 'search_recipes'

  get '/recipes', to: 'recipes#index', as: 'recipes'
  # get '/main', to: 'recipes#new', as: 'recipes_new'
  # post '/main', to: 'recipes#create', as: 'recipes_create'
end
