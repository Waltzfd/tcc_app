Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "static_pages/home"
  get "home/index"
  resources :meal_plans
  resources :ingredients
  resources :meals
  resources :recipes
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root 'home#index'
  resources :users, only: [:new, :create, :show]





  # resources :users # Se você ainda precisar das rotas REST para usuários


  # Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  # get "static_pages/home"
  #resources :users, only: [:new, :create, :show] # Adiciona apenas as rotas necessárias
    # ... outras rotas
  #end


  Rails.application.routes.draw do
    resources :users, only: [:new, :create]
    # ... outras rotas ...
  end

  #se der problema excluir daqui pra baixo
  # config/routes.rb
  Rails.application.routes.draw do
    # ... suas outras rotas ...

    # Rota para exibir o formulário de login
    get '/login', to: 'sessions#new'

    # Rota para processar o formulário de login
    post '/login', to: 'sessions#create'

    # Defina sua página inicial, por exemplo:
    # root 'pages#home'

    #se der problema só tirar
    Rails.application.routes.draw do
      # Define a rota para a ação show do MealPlansController
      # Você pode adicionar outras ações conforme necessário (index, new, create, etc.)
      resources :meal_plans, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
        # Se precisar de rotas aninhadas para refeições dentro de um plano
        # resources :meals # Exemplo: /meal_plans/:meal_plan_id/meals
      end

      # Exemplo de rota root (página inicial)
      # root 'home#index'

      # Outras rotas do seu aplicativo
    end
    #se der problema mudadr
    Rails.application.routes.draw do
      # Rotas para DailyFoodLogs
      resources :daily_food_logs

      # Defina a rota raiz se quiser, por exemplo:
      # root 'daily_food_logs#index'
    end

  end
end