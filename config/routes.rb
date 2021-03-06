Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/server_error'
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#home'
  namespace :admin do   
    resources :users, only: [:index, :edit, :destroy]
  end
  resources :users,  except: [:index, :destroy, :show] 
  resources :tasks
    
  get 'signup' => 'users#new'
  get  'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy' 

  
  match '/404', via: :all, to: 'errors#not_found'
  match '/500', via: :all, to: 'errors#server_error'
end
