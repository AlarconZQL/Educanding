Rails.application.routes.draw do


  get 'users/index'

  get 'sessions/index'

  root 'questions#index'

  get 'questions/index'

  post 'sessions/create'

  get 'sessions/destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
