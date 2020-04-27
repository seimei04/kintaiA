Rails.application.routes.draw do
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  #ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
   #　Baseモデル
  resources :bases, except: [ :edit, :show]
  #get 'bases', to: 'bases#index'
  #patch 'bases/:id', to: 'bases#update'
  #delete 'bases/:id', to: 'bases#destroy'
  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month' # この行が追加対象です。
      patch 'attendances/update_one_month'
      get 'attend_index'
    end
    collection { post :import }
    resources :attendances, only: :update
  end
 
  

end

