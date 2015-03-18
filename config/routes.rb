Rails.application.routes.draw do

  resources :accounts do
    resources :doctors
    resources :laboratories do
      resources :trial_types
      resources :orders do
        collection do
          get :export
        end
        resources :trials
      end
    end
  end

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :antibodies
end
