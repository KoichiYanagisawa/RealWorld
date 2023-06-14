Rails.application.routes.draw do
  get 'articles/create'
  # get 'sessions/create'
  post '/users', to: 'users#create'
  post '/users/login', to: 'sessions#create'
  post '/articles', to: 'articles#create'
end
