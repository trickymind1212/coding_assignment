Rails.application.routes.draw do
  resources :courses, only: :create do
    get 'list', on: :collection
  end

  resources :tutors, only: :create
end
