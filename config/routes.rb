Rails.application.routes.draw do
  root 'static#index'

  resources :tokens, only: [:create]

  resources :packs, only: %i[index create show destroy] do
    member do
      post :clear
    end
    resources :entries, only: %i[index create show destroy] do
      collection do
        post :bulk
      end
    end
    resources :search, only: :index
  end
end
