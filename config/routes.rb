Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :targets, only: %i[index create] do
    get :topic_icon, on: :collection
  end
end
