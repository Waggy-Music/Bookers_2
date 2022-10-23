Rails.application.routes.draw do


  devise_for :users
  root to: "homes#top"
 # get 'homes/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
 
 resources :users,only:[:show,:edit,:update, :index]
 resources :books
 get "home/about"=> "homes#about",as: "about"
 
 
  
end
