Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  authenticated :user, ->(user) { user.receptionist? } do
    root to: 'receptionists#dashboard', as: :receptionist_root
  end
  authenticated :user, ->(user) { user.doctor? } do
    root to: 'doctors#dashboard', as: :doctor_root
  end
  get 'receptionist/dashboard', to: 'receptionists#dashboard'
  resources :patients
  resources :appointments
  resources :doctors
  resources :specializations
  root "home#index"
end
