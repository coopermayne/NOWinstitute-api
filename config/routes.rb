Rails.application.routes.draw do

  #match routes with query params... this is for bad google results
  get 'sitemap.xml', :to => 'site_map#index', :defaults => {:format => 'xml'}

  get "/", to: redirect('/404'),
    constraints: lambda { |request| !( request.params.keys & ['p', 'attachment_id', 'tag', 'say', 's', 'author'] ).empty? }

  get 'search' =>  'search_results#index'

  #no sign up
  get 'admin', to: redirect('/admin/projects')
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
  get 'about' =>  'pages#about'
  get 'about/contact' =>  'pages#contact'
  get 'about/people' =>  'people#index'

  resources :projects, path: "projects", only: [:index, :show]
  resources :projects, path: "research", only: [:index, :show]
  resources :news_items, path: "news", only: [:index, :show]
  resources :people, path: "about/people", only: [:index, :show]
end
