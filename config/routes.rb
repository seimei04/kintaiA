Rails.application.routes.draw do
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  #ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month' # この行が追加対象です。
      patch 'attendances/update_one_month'
      get 'attend_index'
    end
    resources :attendances, only: :update
  end
  get 'bases/new'
  get 'bases', to: 'bases#index'
  delete 'bases/:id', to: 'bases#destroy'

end

