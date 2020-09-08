Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :profiles, only: [:index, :show, :edit, :update] do
    member do
     delete :unfollow
     post :follow
    end
  end

  root 'home#index'
end
