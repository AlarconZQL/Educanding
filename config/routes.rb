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
  post 'questions_comments/create'
  post 'answers_comments/create'
  post 'answers/create'
  post 'cars/create'
  post 'cats/create'
  post 'dogs/create'
  post 'cows/create'

  get 'labels/delete'
  get 'labels/update'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
