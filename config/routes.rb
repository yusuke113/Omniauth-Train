Rails.application.routes.draw do

  root to: 'home#index'
  devise_for :users,
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get 'users/show' => 'users#show'

end
