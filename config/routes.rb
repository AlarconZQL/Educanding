Rails.application.routes.draw do


  resources :questions
  get 'users/index'

  get 'sessions/index'

  root 'questions#index'

  get 'questions/index'

  get 'questions/show'
  
  post 'sessions/create'

  get 'sessions/destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
