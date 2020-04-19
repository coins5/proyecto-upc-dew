Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sedes
  resources :exams
  resources :users do
    resources :user_exams
  end
end
