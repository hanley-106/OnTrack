Rails.application.routes.draw do
  devise_for :users
  get 'admin_panel/index'
  post 'admin_panel/index'
  get 'admin_panel/modify'
  get 'data_scraper/organize'
  post 'data_scraper/organize'
  get 'data_scraper/load'
  post 'data_scraper/load'
  get 'configuration/index'
  post 'configuration/index'
  get 'recommendations/list'
  get 'recommendations/new'
  get 'recommendations/show'
  get 'recommendations/edit'
  get 'recommendations/destroy'
  root 'menu#index'
  get 'menu/index'
  post 'menu/index'
  get 'data_scraper/scrape'
  post 'data_scraper/scrape'
  get 'student_application/index'
  post 'student_application/index'
  get 'student_application/new'
  post 'student_application/new'
  get 'student_application/create'
  post 'student_application/create'
  get 'student_application/show'
  get  'student_application/edit'
  get 'student_applicaiton/update'
  put 'student_application/update'
  get 'student_application/delete'
  delete 'student_application/delete'
  get 'evaluations/index'
  post 'evaluations/index'

  # Added for testing recommendation form
  #get '/' =>'recommendations#new'
  post 'recommendations/new'
  get 'recommendation/create'
  post 'recommendation/create'
  get 'recommendation/show'
  post 'recommendation/show'
  post 'recommendations/create' => 'recommendations#create'
  post 'recommendations/show' => 'recommendations#show'
  delete 'recommendations/show' => 'recommendations#delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
