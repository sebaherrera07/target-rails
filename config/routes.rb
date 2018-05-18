Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'targets#index'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    mailer: 'users/mailer',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resources :targets, only: %i[index create] do
    get :topic_icon, on: :collection
  end
end
