Rails.application.routes.draw do
  resources :messages
  resources :clovas
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  post '/linebot/callback' => 'linebot#callback'
  post '/clova/callback' => 'clova#callback'
end
