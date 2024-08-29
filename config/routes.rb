Rails.application.routes.draw do
  get 'welcome/index'
  resources :coins
  resources :mining_types
  root to: 'welcome#index'
end
