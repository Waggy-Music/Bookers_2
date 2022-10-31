Rails.application.routes.draw do


  devise_for :users
  root to: "homes#top"
 # get 'homes/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
 resources :books do
 resource :favorites,only:[:create, :destroy]
 resources:book_comments,only: [:create, :destroy]
end

 resources :users,only:[:show,:edit,:update, :index]
 get "home/about"=> "homes#about",as: "about"
 
 
  
end
