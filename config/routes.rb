Rails.application.routes.draw do
  root 'static#index'

  resources :tokens, only: [:create] do
    collection do
      get :generate
    end
  end

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
