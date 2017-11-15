Rails.application.routes.draw do


  resources :questions
  get 'users/index'
  post 'users/create'

  get 'sessions/index'

  root 'questions#index'

  get 'questions/index'
  post 'questions/create'

  get 'questions/show'

  post 'sessions/create'

  get 'sessions/destroy'

  get 'labels/index'

  post 'labels/create'
  post 'question_votes/create'

  post 'cars/create'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
