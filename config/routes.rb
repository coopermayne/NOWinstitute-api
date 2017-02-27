Rails.application.routes.draw do

  get 'search' =>  'search_results#index'

  #no sign up
  devise_for :users, path_prefix: 'd',  controllers: { registrations: "registrations"}

  get 'press_list' => 'press#create'

  #admin routes
  namespace :admin do
    get 'press_list' => 'press#index'
    get 'clear_press_list' => 'press#clear'

		resources :uploads
    resources :slides do
      collection do
        put :rank
      end
    end
		resources :people
		resources :positions
		resources :news_items
		resources :projects

    resources :project_types do
      collection do
        put :rank
      end
    end

    #minor
    resources :news_types
    resources :file_types
    resources :credits

    resources :users
    resources :awards
    resources :bibliography_items
  end


  root 'pages#main'

  # Example of regular route:
  resources :projects, path: "projects", only: [:index, :show]
  resources :projects, path: "research", only: [:index, :show]
  resources :news_items, path: "news", only: [:index, :show]
  resources :people, path: "about/people", only: [:index, :show]
end
