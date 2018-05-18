Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  as :user do
    unauthenticated { root 'users/sessions#new' }
    authenticated { root 'targets#index' }
  end

  devise_for :users, controllers: {
    confirmations:  'users/confirmations',
    passwords:      'users/passwords',
    registrations:  'users/registrations',
    sessions:       'users/sessions'
  }, skip: %i[registrations]

  devise_scope :user do
    get   '/users/sign_up', to: 'users/registrations#new',    as: :new_user_registration
    patch '/users',         to: 'users/registrations#update', as: :user_registration
    post  '/users',         to: 'users/registrations#create', as: nil
  end

  resources :targets, only: %i[index create] do
    get :topic_icon, on: :collection
  end
end
