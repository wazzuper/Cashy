Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  root 'pages#welcome'
  get 'activity_page', to: 'pages#activity_page'
  resources :transactions
end
