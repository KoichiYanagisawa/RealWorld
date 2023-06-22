Rails.application.routes.draw do
  scope :api do
    get 'elb/ok'
    post '/users', to: 'users#create'
    post '/users/login', to: 'sessions#create'
    post '/articles', to: 'articles#create'
    get '/articles/:slug', to: 'articles#show'
    put '/articles/:slug', to: 'articles#update'
    delete '/articles/:slug', to: 'articles#destroy'
  end
end
